//
//  BrowseOverflowViewControllerTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BrowseOverflowViewController.h"
#import "TopicTableDataSource.h"
#import "TopicTableDelegate.h"
#import <objc/runtime.h>

@interface BrowseOverflowViewControllerTests : XCTestCase {
  BrowseOverflowViewController *viewController;
  UITableView *tableView;
  id <UITableViewDataSource> dataSource;
  TopicTableDelegate *delegate;
}

@end

@implementation BrowseOverflowViewControllerTests

- (void)setUp
{
  [super setUp];
  // Put setup code here; it will be run once, before the first test case.
  viewController = [[BrowseOverflowViewController alloc] init];
  tableView = [[UITableView alloc] init];
  dataSource = [[TopicTableDataSource alloc] init];
  delegate = [[TopicTableDelegate alloc] init];
  viewController.tableView = tableView;
  viewController.dataSource = dataSource;
  viewController.tableViewDelegate = delegate;
}

- (void)tearDown
{
  viewController = nil;
  tableView = nil;
  dataSource = nil;
  // Put teardown code here; it will be run once, after the last test case.
  [super tearDown];
}

- (void)testViewControllerHasATableViewProperty
{
  objc_property_t tableViewProperty = class_getProperty([viewController class], "tableView");
  XCTAssertTrue(tableViewProperty != NULL, @"BrowseOverflowViewController needs a table view");
}

- (void)testViewControllerHasADataSourceProperty
{
  objc_property_t dataSourceProperty = class_getProperty([viewController class], "dataSource");
  XCTAssertTrue(dataSourceProperty != NULL, @"View Controller needs a data source");
}

- (void)testViewControllerHasATableViewDelegateProperty
{
  objc_property_t delegateProperty = class_getProperty([viewController class], "tableViewDelegate");
  XCTAssertTrue(delegateProperty != NULL, @"View Controller needs a table view delegate");
}

- (void)testViewControlerConnectsDataSourceInViewDidLoad
{
  [viewController viewDidLoad];
  XCTAssertEqualObjects([tableView dataSource], dataSource, @"View controller should have set the table view's data source");
}

- (void)testViewControlerConnectsDelegateInViewDidLoad
{
  [viewController viewDidLoad];
  XCTAssertEqualObjects([tableView delegate], delegate, @"View controller should have set the table view's delegate");
}

- (void)testViewControllerConnectsDataSourceToDelegate
{
  [viewController viewDidLoad];
  XCTAssertEqualObjects([delegate tableDataSource], dataSource, @"The view controller should tell the table view delegate about its data source");
}

@end
