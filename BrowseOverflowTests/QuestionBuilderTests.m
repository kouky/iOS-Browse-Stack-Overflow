//
//  QuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

static NSString *questionJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"questions\": ["
@"{"
@"\"tags\": ["
@"\"iphone\","
@"\"security\","
@"\"keychain\""
@"],"
@"\"answer_count\": 1,"
@"\"accepted_answer_id\": 3231900,"
@"\"favorite_count\": 1,"
@"\"question_timeline_url\": \"/questions/2817980/timeline\","
@"\"question_comments_url\": \"/questions/2817980/comments\","
@"\"question_answers_url\": \"/questions/2817980/answers\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 23743,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"Graham Lee\","
@"\"reputation\": 13459,"
@"\"email_hash\": \"563290c0c1b776a315b36e863b388a0c\""
@"},"
@"\"creation_date\": 1273660706,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 2,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 465,"
@"\"score\": 2,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>I've been trying to use persistent keychain references.</p>\""
@"}"
@"]"
@"}";

@interface QuestionBuilderTests : XCTestCase{
    QuestionBuilder *questionBuilder;
    Question *question;
    NSString *stringIsNotJSON;
    NSString *noQuestionsJSONString;
    NSString *emptyQuestionsArrayJSON;
}

@end

@implementation QuestionBuilderTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    questionBuilder  = [[QuestionBuilder alloc] init];
    question = [[questionBuilder questionsFromJSON:questionJSON error:NULL] objectAtIndex:0];
    stringIsNotJSON = @"Not JSON";
    noQuestionsJSONString = @"{ \"noquestions\": true }";
    emptyQuestionsArrayJSON = @"{ \"questions\": [] }";
}

- (void)tearDown
{
    questionBuilder = nil;
    question = nil;
    stringIsNotJSON = nil;
    emptyQuestionsArrayJSON = nil;
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([questionBuilder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON
{
    XCTAssertNil([questionBuilder questionsFromJSON:stringIsNotJSON error:NULL], @"This paramater should not be parsable");
}

- (void)testErrorSetWhenStringIsNotJSON
{
    NSError *error = nil;
    [questionBuilder questionsFromJSON:stringIsNotJSON error:&error];
    XCTAssertNotNil(error, @"An error occured we should be told");
}

- (void)testPassingNULLErrorDoesNotCauseCrash
{
    XCTAssertNoThrow([questionBuilder questionsFromJSON:stringIsNotJSON error:NULL], @"Using a NULL error parameter should not be a problem");
}

- (void)testRealJSONWithoutQuestionsArrayIsError
{
    XCTAssertNil([questionBuilder questionsFromJSON:noQuestionsJSONString error:NULL], @"No questions to parse in this JSON");
}

- (void)testRealJSONWithoutQuestionsReturnsMissingDataError
{
    NSError *error = nil;
    [questionBuilder questionsFromJSON:noQuestionsJSONString error:&error];
    XCTAssertEqual([error code], QuestionBuilderMissingDataError, @"This case should not be an invalid JSON error");
}

- (void)testJSONWithOneQuestionReturnsOneQuestionObject
{
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON:questionJSON error:&error];
    XCTAssertEqual([questions count], (NSUInteger)1, @"The build should have created a questions");
}

- (void)testQuestionCreatedFromJSONHasPropertiesPresentedInJSON {
    XCTAssertEqual(question.questionID, 2817980, @"The question ID should match the data we sent");
    XCTAssertEqual([question.date timeIntervalSince1970], (NSTimeInterval)1273660706, @"The date of the question should match the data");
    XCTAssertEqualObjects(question.title, @"Why does Keychain Services return the wrong keychain content?", @"Title should match the provided data");
    XCTAssertEqual(question.score, 2, @"Score should match the data");
    Person *asker = question.asker;
    XCTAssertEqualObjects(asker.name, @"Graham Lee", @"Looks like I should have asked this question");
    XCTAssertEqualObjects([asker.avatarURL absoluteString], @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c", @"The avatar URL should be based on the supplied email hash");
}

- (void)testBuildingQuestionBodyWithNoDataCannotBeTried
{
    XCTAssertThrows([questionBuilder fillInDetailsForQuestion:question fromJSON:nil], @"Not receiving data should have been handled earlier");
}

- (void)testBuildingQuestionBodyWithNoQuestionCannotBeTried
{
    XCTAssertThrows([questionBuilder fillInDetailsForQuestion:nil fromJSON:questionJSON], @"No reason to expect that a nil question is passed");
}

- (void)testNonJSONDataDoesNotCauseABodyToBeAddedToAQuestion
{
    [questionBuilder fillInDetailsForQuestion:question fromJSON:stringIsNotJSON];
    XCTAssertNil(question.body, @"Body should not have been added");
}

- (void)testJSONWhichDoesNotContainABodyDoesNotCauseBodyToBeAdded
{
    [questionBuilder fillInDetailsForQuestion:question fromJSON:noQuestionsJSONString];
    XCTAssertNil(question.body, @"Body should not have benn added");
}

- (void)testBodyContainedInJSONIsAddedToQuestion
{
    [questionBuilder fillInDetailsForQuestion:question fromJSON:questionJSON];
    XCTAssertEqualObjects(question.body, @"<p>I've been trying to use persistent keychain references.</p>", @"The correct question body is added");
}

- (void)testEmptyQuestionsArrayDoesNotCrash
{
  XCTAssertNoThrow([questionBuilder fillInDetailsForQuestion:question fromJSON:emptyQuestionsArrayJSON], @"Don't throw an error if no questions are found.");
}

@end
