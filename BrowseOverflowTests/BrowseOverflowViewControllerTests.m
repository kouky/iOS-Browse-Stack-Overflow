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
#import <objc/runtime.h>

static const char *notificationKey = "BrowseOverflowViewControllerTestsAssociatedNotificationKey";

#pragma mark Categories on BrowseOverflowController

@implementation BrowseOverflowViewController (TestNotificationDelivery)

- (void)userDidSelectTopicNotification:(NSNotification *)note
{
  objc_setAssociatedObject(self, notificationKey, note, OBJC_ASSOCIATION_RETAIN);
}

@end

# pragma mark Tests

@interface BrowseOverflowViewControllerTests : XCTestCase {
  BrowseOverflowViewController *viewController;
  UITableView *tableView;
  id <UITableViewDataSource, UITableViewDataSource> dataSource;
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
  viewController.tableView = tableView;
  viewController.dataSource = dataSource;
  objc_removeAssociatedObjects(viewController);
}

- (void)tearDown
{
  objc_removeAssociatedObjects(viewController);
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

- (void)testViewControllerConnectsDataSourceInViewDidLoad
{
  [viewController viewDidLoad];
  XCTAssertEqualObjects([tableView dataSource], dataSource, @"View controller should have set the table view's data source");
}

- (void)testViewControllerConnectsDelegateInViewDidLoad
{
  [viewController viewDidLoad];
  XCTAssertEqualObjects([tableView delegate], dataSource, @"View controller should have set the table view's delegate");
}

- (void)testDefaultStateOfViewControllerDoesNotReceiveNotifications
{
  [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification
                                                      object:nil
                                                    userInfo:nil];
  XCTAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"Notification should not be received before -viewDidAppear:");
}

- (void)testViewControllerReceivesTableSelectionNotificationAfterViewDidAppear
{
  [viewController viewDidAppear:NO];
  [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification
                                                        object:nil
                                                    userInfo:nil];
  XCTAssertNotNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewDidAppear: the view controller should handle selection notifications");
}

- (void)testViewControllerDoesNotReceiveTableSelectionNotificationAfterViewWillDisappear
{
  [viewController viewDidAppear:NO];
  [viewController viewWillDisappear:NO];
  [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification
                                                      object:nil
                                                    userInfo:nil];
  XCTAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewWillDisappear: the view controller should no longer respond to topic notifications");
  
}

@end
