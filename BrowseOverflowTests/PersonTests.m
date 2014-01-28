//
//  PersonTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTests : XCTestCase {
    Person *person;
}

@end

@implementation PersonTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    person = [[Person alloc] initWithName: @"Graham Lee" avatarLocation: @"http://example.com/avatar.png"];
    
}

- (void)tearDown
{
    person = nil;
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testThatPersonHasTheRightName
{
    XCTAssertEqualObjects(person.name, @"Graham Lee", @"expecting a person to provide its name");
}

- (void)testThatPersonHasAnAvatarURL
{
    XCTAssertEqualObjects([person.avatarURL absoluteString], @"http://example.com/avatar.png", @"The persons avatar should be represented by a URL");
}

@end
