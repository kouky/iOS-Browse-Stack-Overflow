//
//  AppDelegateTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface AppDelegateTests : XCTestCase {
  AppDelegate *appDelegate;
  BOOL didFinishLaunchingWithOptionsReturn;
}

@end

@implementation AppDelegateTests

- (void)setUp
{
  [super setUp];
  appDelegate = [[AppDelegate alloc] init];
  didFinishLaunchingWithOptionsReturn = [appDelegate application: nil didFinishLaunchingWithOptions: nil];
}

- (void)tearDown
{
  appDelegate = nil;
  // Put teardown code here; it will be run once, after the last test case.
  [super tearDown];
}

- (void)testWindowIsKeyAfterApplicationLaunch
{
  XCTAssertTrue(appDelegate.window.keyWindow, @"App delegate's window should be key");
}

- (void)testWindowHasRootNavigationControllerAfterApplicationLaunch
{
  XCTAssertEqualObjects(appDelegate.window.rootViewController, appDelegate.navigationController, @"App delegate's navigation controller should be the root VC");
}

- (void)testAppDidFinishLaunchingReturnsYES
{
  XCTAssertTrue(didFinishLaunchingWithOptionsReturn, @"Method should return YES");
}

@end
