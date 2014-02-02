//
//  QuestionCreationTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "Topic.h"
#import "MockStackoverflowCommunicator.h"

@interface QuestionCreationTests : XCTestCase {
    StackOverflowManager *mgr;
    MockStackoverflowManagerDelegate *delegate;
    NSError *underlyingError;
}
@end

@implementation QuestionCreationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackoverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
}

- (void)tearDown
{
 
    delegate = nil;
    mgr = nil;
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
    MockStackoverflowCommunicator *communicator = [[MockStackoverflowCommunicator alloc] init];
    mgr.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionsOnTopic:topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data");
}

- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByComminicator
{
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error shoudl be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlingError
{
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

@end
