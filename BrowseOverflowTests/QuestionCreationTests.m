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

@interface QuestionCreationTests : XCTestCase {
    StackOverflowManager *mgr;
    MockStackoverflowManagerDelegate *delegate;
}
@end

@implementation QuestionCreationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackoverflowManagerDelegate alloc] init];
}

- (void)tearDown
{
 
    delegate = nil;
    mgr = nil;
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

@end
