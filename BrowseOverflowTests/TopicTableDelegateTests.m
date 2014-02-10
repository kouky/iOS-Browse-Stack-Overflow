//
//  TopicTableDelegateTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 10/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopicTableDataSource.h"
#import "Topic.h"

@interface TopicTableDelegateTests : XCTestCase {
  NSNotification *receivedNotification;
  TopicTableDataSource *dataSource;
  Topic *iPhoneTopic;
}

@end

@implementation TopicTableDelegateTests

- (void)setUp
{
  [super setUp];
  // Put setup code here; it will be run once, before the first test case.
  dataSource = [[TopicTableDataSource alloc] init];
  iPhoneTopic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
  
  [dataSource setTopics:@[iPhoneTopic]];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(didReceiveNotification:)
                                               name:TopicTableDidSelectTopicNotification object:nil];
}

- (void)tearDown
{
  receivedNotification = nil;
  dataSource = nil;
  iPhoneTopic = nil;
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  // Put teardown code here; it will be run once, after the last test case.
  [super tearDown];
}

- (void)didReceiveNotification:(NSNotification *)note
{
  receivedNotification = note;
}

- (void)testDelegatePostsNotificationOnSelectionShowingWhichTopicWasSelected
{
  NSIndexPath *selection = [NSIndexPath indexPathForItem:0 inSection:0];
  [dataSource tableView:nil didSelectRowAtIndexPath:selection];
  XCTAssertEqualObjects([receivedNotification name], @"TopicTableDidSelectTopicNotification", @"The delegate should notify that a topic was selected");
  XCTAssertEqualObjects([receivedNotification object], iPhoneTopic, @"The notification should indicate which topic was selected");
}

@end
