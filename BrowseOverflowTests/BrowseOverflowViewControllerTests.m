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
static const char *viewDidAppearkey = "BrowseOverflowViewControllerTestsViewDidAppearKey";
static const char *viewWillDisappearKey = "BrowseOverflowViewControllerTestsViewWillDisappearKey";

#pragma mark Categories on BrowseOverflowController

@implementation BrowseOverflowViewController (TestNotificationDelivery)

- (void)userDidSelectTopicNotification:(NSNotification *)note
{
  objc_setAssociatedObject(self, notificationKey, note, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation UIViewController (TestSuperClassCalled)

- (void)browseOverflowViewControllerTests_viewDidAppear:(BOOL)animated
{
  NSNumber *paramter = [NSNumber numberWithBool:animated];
  objc_setAssociatedObject(self, viewDidAppearkey, paramter, OBJC_ASSOCIATION_RETAIN);
}

- (void)browseOverflowViewControllerTests_viewWillDisappear:(BOOL)animated
{
  NSNumber *paramter = [NSNumber numberWithBool:animated];
  objc_setAssociatedObject(self, viewWillDisappearKey, paramter, OBJC_ASSOCIATION_RETAIN);
}

@end

# pragma mark Tests

@interface BrowseOverflowViewControllerTests : XCTestCase {
  BrowseOverflowViewController *viewController;
  UITableView *tableView;
  id <UITableViewDataSource, UITableViewDataSource> dataSource;
  SEL realViewDidAppear, testViewDidAppear;
  SEL realViewWillDisappear, testViewWillDisappear;
}

@end

@implementation BrowseOverflowViewControllerTests

+ (void)swapInstanceMethodsForClass:(Class)cls selector:(SEL)sel1 andSelector:(SEL)sel2
{
  Method method1 = class_getInstanceMethod(cls, sel1);
  Method method2 = class_getInstanceMethod(cls, sel2);
  method_exchangeImplementations(method1, method2);
}

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
  
  realViewDidAppear = @selector(viewDidAppear:);
  testViewDidAppear = @selector(browseOverflowViewControllerTests_viewDidAppear:);
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class]
                                                        selector:realViewDidAppear
                                                     andSelector:testViewDidAppear];
  
  realViewWillDisappear = @selector(viewWillDisappear:);
  testViewWillDisappear = @selector(browseOverflowViewControllerTests_viewWillDisappear:);
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class]
                                                        selector:realViewWillDisappear
                                                     andSelector:testViewWillDisappear];
}

- (void)tearDown
{
  objc_removeAssociatedObjects(viewController);
  viewController = nil;
  tableView = nil;
  dataSource = nil;

  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class]
                                                        selector:realViewDidAppear
                                                     andSelector:testViewDidAppear];
  
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class]
                                                        selector:realViewWillDisappear
                                                     andSelector:testViewWillDisappear];
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

- (void)testViewControllerCallsSuperViewDidAppear
{
  [viewController viewDidAppear:NO];
  XCTAssertNotNil(objc_getAssociatedObject(viewController, viewDidAppearkey), @"-viewDidAppear: should call through to superclass implementation");
}

- (void)testViewControllerCallsSuperViewWillDisappear
{
  [viewController viewWillDisappear:NO];
  XCTAssertNotNil(objc_getAssociatedObject(viewController, viewWillDisappearKey), @"-viewWillDisappear: should call through to superclass implementation ");
}

@end
