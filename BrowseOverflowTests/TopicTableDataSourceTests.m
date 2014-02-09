//
//  TopicTableDataSourceTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 10/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopicTableDataSource.h"
#import "Topic.h"

@interface TopicTableDataSourceTests : XCTestCase {
  TopicTableDataSource *dataSource;
  NSArray *topicsList;
}
@end

@implementation TopicTableDataSourceTests

- (void)setUp
{
  [super setUp];
  // Put setup code here; it will be run once, before the first test case.
  dataSource = [[TopicTableDataSource alloc] init];
  Topic *sampleTopic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
  topicsList = @[sampleTopic];
  [dataSource setTopics:topicsList];
}

- (void)tearDown
{
  dataSource = nil;
  topicsList = nil;
  // Put teardown code here; it will be run once, after the last test case.
  [super tearDown];
}

- (void)testOneTableRowForOneTopic
{
  XCTAssertEqual((NSInteger)[topicsList count], [dataSource tableView:nil numberOfRowsInSection:0], @"As there is one topic there should be one row in the table");
}

- (void)testTwoTableRowsForTwoTopics
{
  Topic *topic1 = [[Topic alloc] initWithName:@"Mac OS X" tag:@"macosx"];
  Topic *topic2 = [[Topic alloc] initWithName:@"Cocoa" tag:@"cocoa"];
  NSArray *twoTopicsList = @[topic1, topic2];
  [dataSource setTopics:twoTopicsList];
  XCTAssertEqual((NSInteger)[twoTopicsList count], [dataSource tableView:nil numberOfRowsInSection:0], @"There should be two rows in the table for two topics");
  
}

- (void)testSectionOneInTheTableView
{
  XCTAssertThrows([dataSource tableView:nil numberOfRowsInSection:1], @"Data source doesn;t allow asking about additonal sections");
}

- (void)testDataSourceCellCreationExpectsOneSection {
  NSIndexPath *secondSection = [NSIndexPath indexPathForRow: 0 inSection: 1];
  XCTAssertThrows([dataSource tableView: nil cellForRowAtIndexPath: secondSection], @"Data source will not prepare cells for unexpected sections");
}

- (void)testDataSourceCellCreationWillNotCreateMoreRowsThanItHasTopics {
  NSIndexPath *afterLastTopic = [NSIndexPath indexPathForRow: [topicsList count] inSection: 0];
  XCTAssertThrows([dataSource tableView: nil cellForRowAtIndexPath: afterLastTopic], @"Data source will not prepare more cells than there are topics");
}

- (void)testCellCreatedByDataSourceContainsTopicTitleAsTextLabel {
  NSIndexPath *firstTopic = [NSIndexPath indexPathForRow: 0 inSection: 0];
  UITableViewCell *firstCell = [dataSource tableView: nil cellForRowAtIndexPath: firstTopic];
  NSString *cellTitle = firstCell.textLabel.text;
  XCTAssertEqualObjects(@"iPhone", cellTitle, @"Cell's title should be equal to the topic's title");
}

@end
