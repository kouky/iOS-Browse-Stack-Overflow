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
#import "Topic.h"
#import "Question.h"
#import "QuestionListTableDataSource.h"
#import "QuestionDetailDataSource.h"
#import "BrowseOverflowObjectConfiguration.h"
#import <objc/runtime.h>

static const char *notificationKey = "BrowseOverflowViewControllerTestsAssociatedNotificationKey";
static const char *viewDidAppearKey = "BrowseOverflowViewControllerTestsViewDidAppearKey";
static const char *viewWillDisappearKey = "BrowseOverflowViewControllerTestsViewWillDisappearKey";

#pragma mark Categories on BrowseOverflowController

@implementation BrowseOverflowViewController (TestNotificationDelivery)

- (void)browseOverflowControllerTests_userDidSelectTopicNotification:(NSNotification *)note
{
  objc_setAssociatedObject(self, notificationKey, note, OBJC_ASSOCIATION_RETAIN);
}

- (void)browseOverflowControllerTests_userDidSelectQuestionNotification:(NSNotification *)note
{
  objc_setAssociatedObject(self, notificationKey, note, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation UIViewController (TestSuperClassCalled)

- (void)browseOverflowViewControllerTests_viewDidAppear:(BOOL)animated
{
  NSNumber *paramter = [NSNumber numberWithBool:animated];
  objc_setAssociatedObject(self, viewDidAppearKey, paramter, OBJC_ASSOCIATION_RETAIN);
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
  SEL realUserDidSelectTopic, testUserDidSelectTopic;
  SEL realUserDidSelectQuestion, testUserDidSelectQuestion;
  UINavigationController *navController;
  Question *question;
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
  
  realUserDidSelectTopic = @selector(userDidSelectTopicNotification:);
  testUserDidSelectTopic = @selector(browseOverflowControllerTests_userDidSelectTopicNotification:);
  
  realUserDidSelectQuestion = @selector(userDidSelectQuestionNotification:);
  testUserDidSelectQuestion = @selector(browseOverflowControllerTests_userDidSelectQuestionNotification:);

  navController = [[UINavigationController alloc] initWithRootViewController:viewController];
  
  question = [[Question alloc] init];
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
  
  navController = nil;
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

- (void)testViewControllerConnectsTableViewBacklinkInViewDidLoad
{
  QuestionListTableDataSource *questionDataSource = [[QuestionListTableDataSource alloc] init];
  viewController.dataSource = questionDataSource;
  [viewController viewDidLoad];
  XCTAssertEqualObjects(questionDataSource.tableView, tableView, @"Backlink to tableview should be set in datasource");
}

- (void)testDefaultStateOfViewControllerDoesNotReceiveNotifications
{
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
  [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification
                                                      object:nil
                                                    userInfo:nil];
  XCTAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"Notification should not be received before -viewDidAppear:");
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
}

- (void)testViewControllerReceivesTopicSelectionNotificationAfterViewDidAppear
{
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
  [viewController viewDidAppear:NO];
  [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification
                                                        object:nil
                                                    userInfo:nil];
  XCTAssertNotNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewDidAppear: the view controller should handle selection notifications");
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
}

- (void)testViewControllerDoesNotReceiveTopicSelectNotificationAfterViewWillDisappear
{
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
  [viewController viewDidAppear:NO];
  [viewController viewWillDisappear:NO];
  [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification
                                                      object:nil
                                                    userInfo:nil];
  XCTAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewWillDisappear: the view controller should no longer respond to topic notifications");
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
}

- (void)testViewControllerCallsSuperViewDidAppear
{
  [viewController viewDidAppear:NO];
  XCTAssertNotNil(objc_getAssociatedObject(viewController, viewDidAppearKey), @"-viewDidAppear: should call through to superclass implementation");
}

- (void)testViewControllerCallsSuperViewWillDisappear
{
  [viewController viewWillDisappear:NO];
  XCTAssertNotNil(objc_getAssociatedObject(viewController, viewWillDisappearKey), @"-viewWillDisappear: should call through to superclass implementation ");
}

- (void)testSelectingTopicPushesNewViewController
{
  [viewController userDidSelectTopicNotification:nil];
  UIViewController *currentTopicVC = [navController topViewController];
  XCTAssertFalse([currentTopicVC isEqual:viewController], @"New view controller should be pushed onto the stack");
  XCTAssertTrue([currentTopicVC isKindOfClass:[BrowseOverflowViewController class]], @"New view controller should be a BrowseOverflowViewController");
}

- (void)testNewViewControllerHasAQuestionListDataSourceForTheSelectedTopic
{
  Topic *iPhoneTopic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
  NSNotification *iPhoneTopicSelectedNotification = [NSNotification notificationWithName:TopicTableDidSelectTopicNotification object:iPhoneTopic];
  [viewController userDidSelectTopicNotification:iPhoneTopicSelectedNotification];
  BrowseOverflowViewController *nextViewController = (BrowseOverflowViewController *)[navController topViewController];
  XCTAssertTrue([nextViewController.dataSource isKindOfClass:[QuestionListTableDataSource class]], @"Selecting a topic should push a list of questions");
  XCTAssertEqualObjects([(QuestionListTableDataSource *)nextViewController.dataSource topic], iPhoneTopic, @"The questions to display shoudl come from the selected topic");
}

- (void)testDefaultStateOfViewControllerDoesNotReceiveQuestionSelectionNotification
{
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectQuestion andSelector:testUserDidSelectQuestion];
  [[NSNotificationCenter defaultCenter] postNotificationName:QuestionListDidSelectQuestionNotification
                                                      object:question
                                                    userInfo:nil];
  XCTAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"View controller shouldn't receive question selection notifications by default");
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class]
                                                        selector:realUserDidSelectQuestion
                                                     andSelector:testUserDidSelectQuestion];
}

- (void)testViewControllerReceivesQuestionSelectionNotificationAfterViewDidAppear
{
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectQuestion andSelector:testUserDidSelectQuestion];
  [viewController viewDidAppear:NO];
  [[NSNotificationCenter defaultCenter] postNotificationName:QuestionListDidSelectQuestionNotification
                                                      object:nil
                                                    userInfo:nil];
  XCTAssertNotNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewDidAppear: the view controller should handle question selection notifications");
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class]
                                                        selector:realUserDidSelectQuestion
                                                     andSelector:testUserDidSelectQuestion];
}

- (void)testViewControllerDoesNotReceiveQuestionSelectNotificationAfterViewWillDisappear
{
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectQuestion andSelector:testUserDidSelectQuestion];
  [viewController viewDidAppear:NO];
  [viewController viewWillDisappear:NO];
  [[NSNotificationCenter defaultCenter] postNotificationName:QuestionListDidSelectQuestionNotification
                                                      object:nil
                                                    userInfo:nil];
  XCTAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewWillDisappear: is called, the view controller should no longer respond to question selection notifications");
  [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class]
                                                        selector:realUserDidSelectQuestion
                                                     andSelector:testUserDidSelectQuestion];
}

- (void)testSelectingQuestionPushesNewViewController
{
  [viewController userDidSelectQuestionNotification:nil];
  UIViewController *currentTopVC = navController.topViewController;
  XCTAssertFalse([currentTopVC isEqual:viewController], @"New view controller should be pushed onto the stack");
  XCTAssertTrue([currentTopVC isKindOfClass:[BrowseOverflowViewController class]], @"New view controller should be a BrowseOverflowViewController");
}

- (void)testViewControllerPushedOnQuestionSelectionHasQuestionDetailDataSourceForSelectedQuestion
{
  Question *sampleQuestion = [[Question alloc] init];
  NSNotification *note = [NSNotification notificationWithName: QuestionListDidSelectQuestionNotification
                                                       object: sampleQuestion];
  [viewController userDidSelectQuestionNotification:note];
  BrowseOverflowViewController *nextVC = (BrowseOverflowViewController *)navController.topViewController;
  XCTAssertTrue([nextVC.dataSource isKindOfClass:[QuestionDetailDataSource class]], @"Selecting a question should show details of that question");
  XCTAssertEqualObjects([(QuestionDetailDataSource *)nextVC.dataSource question], sampleQuestion, @"Details should be shown for the selected question");
}

- (void)testSelectingTopicNotificationPassesObjectConfigurationToNewViewController
{
  BrowseOverflowObjectConfiguration *objectConfiguration = [[BrowseOverflowObjectConfiguration alloc] init];
  viewController.objectConfiguration = objectConfiguration;
  [viewController userDidSelectTopicNotification:nil];
  BrowseOverflowViewController *newTopVC = (BrowseOverflowViewController *)navController.topViewController;
  XCTAssertEqualObjects(newTopVC.objectConfiguration, objectConfiguration, @"The object configuration should be passed through to the new view controller");
}

- (void)testSelectingQuestionNotificationPassesObjectConfigurationToNewViewController
{
  BrowseOverflowObjectConfiguration *objectConfiguration = [[BrowseOverflowObjectConfiguration alloc] init];
  viewController.objectConfiguration = objectConfiguration;
  [viewController userDidSelectQuestionNotification:nil];
  BrowseOverflowViewController *newTopVC = (BrowseOverflowViewController *)navController.topViewController;
  XCTAssertEqualObjects(newTopVC.objectConfiguration, objectConfiguration, @"The object configuration should be passed through to the new view controller");
}

@end
