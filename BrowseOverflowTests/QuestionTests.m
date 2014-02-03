//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "Answer.h"
#import "Person.h"

@interface QuestionTests : XCTestCase {
    Question *question;
    Answer *lowScore;
    Answer *highScore;
    Person *asker;
}
@end

@implementation QuestionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
    question.score = 42;
    question.questionID = 17;
    
    Answer *accepted = [[Answer alloc] init];
    accepted.score = 1;
    accepted.accepted = YES;
    [question addAnswer:accepted];
    
    lowScore = [[Answer alloc] init];
    lowScore.score = -4;
    [question addAnswer:lowScore];
    
    highScore = [[Answer alloc] init];
    highScore.score = 4;
    [question addAnswer:highScore];
    
    asker = [[Person alloc] initWithName: @"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    question.asker = asker;
}

- (void)tearDown
{
    question = nil;
    lowScore = nil;
    highScore = nil;
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testQuestionHasADate
{
    NSDate *testDate = [NSDate distantPast];
    question.date = testDate;
    XCTAssertEqualObjects(question.date, testDate, @"Question needs to provide its date");
}

- (void)testQuestionsKeepScore
{
    XCTAssertEqual(question.score, 42, @"Question needs a numeric score");
}

- (void)testQuestionHasTitle
{
    XCTAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?", @"Question should know its title");
}

- (void)testQuestionHasIdentity {
    XCTAssertEqual(question.questionID, 17, @"Questions need a numeric identifier");
}

- (void)testQuestionCanHaveAnswersAdded
{
    Answer *myAnswer = [[Answer alloc] init];
    XCTAssertNoThrow([question addAnswer:myAnswer], @"Can add answers to questions");
}

- (void)testAcceptedAnswerIsFirst
{
    XCTAssertTrue([[question.answers objectAtIndex:0] isAccepted], @"Accepeted answer comes first");
}

- (void)testHighScoreAnswerBeforeLow
{
    NSInteger highIndex = [question.answers indexOfObject:highScore];
    NSInteger lowIndex = [question.answers indexOfObject:lowScore];
    XCTAssertTrue(highIndex < lowIndex, @"High-scoring answer comes first");
}

- (void)testQuestionWasAskedBySomeone
{
    XCTAssertEqualObjects(question.asker, asker, @"Question shoudl keep track of who asked it");
}

@end
