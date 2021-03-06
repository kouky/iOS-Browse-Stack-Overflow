//
//  AnswerCreationWorkflowTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowCommunicator.h"
#import "MockStackOverflowManagerDelegate.h"
#import "FakeAnswerBuilder.h"

@interface AnswerCreationWorkflowTests : XCTestCase {
  StackOverflowManager *manager;
  MockStackOverflowCommunicator *communicator;
  MockStackOverflowManagerDelegate *delegate;
  Question *question;
  FakeAnswerBuilder *answerBuilder;
  NSError *error;
}

@end

@implementation AnswerCreationWorkflowTests

- (void)setUp {
  manager = [[StackOverflowManager alloc] init];
  communicator = [[MockStackOverflowCommunicator alloc] init];
  manager.communicator = communicator;
  delegate = [[MockStackOverflowManagerDelegate alloc] init];
  manager.delegate = delegate;
  question = [[Question alloc] init];
  question.questionID = 12345;
  answerBuilder = [[FakeAnswerBuilder alloc] init];
  manager.answerBuilder = answerBuilder;
  error = [NSError errorWithDomain: @"Fake Domain" code:42 userInfo:nil];
}

- (void)testAskingForAnswersMeansCommunicatingWithSite
{
  [manager fetchAnswersForQuestion:question];
  XCTAssertEqual(question.questionID, [communicator askedForAnswersToQuestionID], @"Answers to questions are found by communicating with the web site");
}

- (void)testDelegateNotifiedOfFailureToGetAnswers
{
  [manager fetchingAnswersFailedWithError:error];
  XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], error, @"Delegate should be notified of failure to communicate");
}

- (void)testManagerRemembersWhichQuestionToAddAnswersTo
{
  [manager fetchAnswersForQuestion:question];
  XCTAssertEqualObjects(manager.questionToFill, question, @"Manager should know to fill this question in");
}

- (void)testAnswerResponsePassedToAnswerBuilder
{
  [manager receivedAnswerListJSON:@"Fake JSON"];
  XCTAssertEqualObjects([answerBuilder receivedJSON], @"Fake JSON", @"Manager must pass response to builder to get answers constructed");
}

- (void)testQuestionPassedToAnswerBuilder
{
  manager.questionToFill = question;
  [manager receivedAnswerListJSON:@"Fake JSON"];
  XCTAssertEqualObjects(answerBuilder.questionToFill, question, @"Manager must pass the question into the answer builder");
}

- (void)testManagerNotifiesDelegateWhenAnswersAdded
{
  answerBuilder.successful = YES;
  manager.questionToFill = question;
  [manager receivedAnswerListJSON:@"Fake JSON"];
  XCTAssertEqualObjects(delegate.successQuestion, question, @"Manager should call the delegate method");
}

- (void)testManagerNotifiesDelegateWhenAnswersNotAdded
{
  answerBuilder.successful = NO;
  answerBuilder.error = error;
  [manager receivedAnswerListJSON:@"Fake JSON"];
  XCTAssertEqualObjects([[delegate.fetchError userInfo] objectForKey:NSUnderlyingErrorKey], error, @"Manager should pass an error on to the delegate");
}

@end