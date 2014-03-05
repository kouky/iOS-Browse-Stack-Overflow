//
//  BrowseOverflowObjectConfiguration.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BrowseOverflowObjectConfiguration.h"
#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"

@interface BrowseOverflowObjectConfigurationTests : XCTestCase {
  BrowseOverflowObjectConfiguration *configuration;
}

@end

@implementation BrowseOverflowObjectConfigurationTests

- (void)setUp
{
  [super setUp];
  // Put setup code here; it will be run once, before the first test case.
  configuration = [[BrowseOverflowObjectConfiguration alloc] init];
}

- (void)tearDown
{
  configuration = nil;
  // Put teardown code here; it will be run once, after the last test case.
  [super tearDown];
}

- (void)testConfigurationOfCreatedStackOverflowManager
{
  StackOverflowManager *manager = [configuration stackOverflowManager];
  XCTAssertNotNil(manager, @"The StackOverflowManager should exist");
  XCTAssertNotNil(manager.communicator, @"Manager should have a StackOverflowCommunicator");
  XCTAssertNotNil(manager.questionBuilder, @"Manager should have a question builder");
  XCTAssertNotNil(manager.answerBuilder, @"Manager should have an answer builder");
  XCTAssertEqualObjects(manager.communicator.delegate, manager, @"The manager is the communicator's delegate");
}

@end
