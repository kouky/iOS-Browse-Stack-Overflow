//
//  QuestionCreationWorkflowTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "Topic.h"
#import "MockStackOverflowCommunicator.h"
#import "FakeQuestionBuilder.h"
#import "Question.h"

@interface QuestionCreationWorkflowTests : XCTestCase {
    StackOverflowManager *mgr;
    MockStackOverflowManagerDelegate *delegate;
    FakeQuestionBuilder *questionBuilder;
    Question *questionToFetch;
    MockStackOverflowCommunicator *communicator;
    MockStackOverflowCommunicator *bodyCommunicator;
    NSArray *questionArray;
    NSError *underlyingError;
}
@end

@implementation QuestionCreationWorkflowTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    communicator = [[MockStackOverflowCommunicator alloc] init];
    bodyCommunicator = [[MockStackOverflowCommunicator alloc] init];
    questionBuilder = [[FakeQuestionBuilder alloc] init];
    questionToFetch = [[Question alloc] init];
    questionToFetch.questionID = 1234;
    questionArray = @[questionToFetch];
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    
    mgr.delegate = delegate;
    mgr.questionBuilder = questionBuilder;
    mgr.communicator = communicator;
    mgr.bodyCommunicator = bodyCommunicator;
}

- (void)tearDown
{
 
    delegate = nil;
    communicator = nil;
    bodyCommunicator = nil;
    questionBuilder = nil;
    mgr = nil;
    questionToFetch = nil;
    questionArray = nil;
    underlyingError = nil;
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testNonConformingObjectCannotBeDelegate
{
    XCTAssertThrows(mgr.delegate = (id <StackOverflowManagerDelegate>)[NSNull null], @"NSNull should not be used as the delegate as it doesn't conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate
{
    XCTAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void)testManagerAcceptsNilAsADelegate
{
    XCTAssertNoThrow(mgr.delegate = nil, @"It shoudl be acceptable to use nil as an object's delegate");
}

- (void)testAskingForQuestionsMeansRequestingData
{
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionsOnTopic:topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data");
}

- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByComminicator
{
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlingError
{
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

- (void)testQuestionJSONIsPassedToQuestionBuilder
{
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.JSON, @"Fake JSON", @"Downloaded JSON is sent to the builder");
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails
{
    questionBuilder.arrayToReturn = nil;
    questionBuilder.errorToSet = underlyingError;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"The delegate should have found out about the error");
}

- (void)testDelegateNotToldAboutErrorWhenQuestionsReceived
{
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNil([delegate fetchError], @"No error should be received on success");
}

- (void)testDelegateReceivesTheQuestionsDiscoveredByManager
{
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], questionArray, @"The manager should have sent its questions to the delegate");
}

- (void)testEmptyArrayIsPassedToDelegate
{
    questionBuilder.arrayToReturn = @[];
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], @[], @"Returning an empty array is not an error");
}

- (void)testAskingForQuestionBodyMeansRequestingData
{
    [mgr fetchBodyForQuestion:questionToFetch];
    XCTAssertTrue([bodyCommunicator wasAskedToFetchBody], @"The communicator should need to request data for the question body");
}

- (void)testDelegateNotifiedOfFailureToFetchQuestion
{
    [mgr fetchingQuestionBodyFailedWithError:underlyingError];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"Delegate should have found out about this error");
}

- (void)testManagerPassesRetreivedQuestionBodyToQuestionBuilder
{
    [mgr receivedQuestionBodyJSON:@"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.JSON, @"Fake JSON", @"Successfully retreived data should be passed to the builder");
}

- (void)testManagerPassesQuestionItWasSentToQuestionBuilderForFillingIn
{
    [mgr fetchBodyForQuestion:questionToFetch];
    [mgr receivedQuestionBodyJSON:@"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.questionToFill, questionToFetch, @"The question should have been passed to the builderi");
}

- (void)testManagerNotifiesDelegateWhenQuestionBodyIsReceived
{
  [mgr fetchBodyForQuestion:questionToFetch];
  [mgr receivedQuestionBodyJSON: @"Fake JSON"];
  XCTAssertEqualObjects(delegate.bodyQuestion, questionToFetch, @"Update delegate when question body filled");
}

@end
