//
//  StackOverflowCommunicatorTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 5/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InspectableStackOverflowCommunicator.h"

@interface StackOverflowCommunicatorTests : XCTestCase {
    InspectableStackOverflowCommunicator *communicator;
}

@end

@implementation StackOverflowCommunicatorTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    communicator = [[InspectableStackOverflowCommunicator alloc] init];
}

- (void)tearDown
{
    communicator = nil;
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testSearchingForQuestionsOnTopicCallsTopicAPI
{
    [communicator searchForQuestionsWithTag:@"ios"];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/search?tagged=ios&pagesize=20", @"Use the search API to find questions");
}

- (void)testFillingInQuestionBodyCallsQuestionAPI
{
    [communicator downloadInformationForQuestionWithID:12345];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/questions/12345?body=true", @"Use the question API to get the body for a question");
}

- (void)testFetchingAnswersToQuestionCallsQuestionAPI
{
    [communicator downloadAnswersToQuestionWithID:12345];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/questions/12345/answers?body=true", @"Use the question API to get answers on a given question");
}

- (void)testSearchingForQuestionsCreatesURLConnection
{
    [communicator searchForQuestionsWithTag:@"ios"];
    XCTAssertNotNil([communicator currentURLConnection], @"There should be a URL connection in flight right now");
    [communicator cancelAndDiscardURLConnection];
}

- (void)testStartingNewSearchThrowsOutOldConnection
{
    [communicator searchForQuestionsWithTag:@"ios"];
    NSURLConnection *firstConnection = [communicator currentURLConnection];
    [communicator searchForQuestionsWithTag:@"cocoa"];
    XCTAssertNotEqualObjects([communicator currentURLConnection], firstConnection, @"The communicator needs to replace its URL connection");
    [communicator cancelAndDiscardURLConnection];
}

@end
