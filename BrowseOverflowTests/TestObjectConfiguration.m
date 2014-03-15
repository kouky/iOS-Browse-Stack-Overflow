//
//  TestObjectConfiguration.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 15/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TestObjectConfiguration.h"

@implementation TestObjectConfiguration

- (StackOverflowManager *)stackOverflowManager
{
  return (StackOverflowManager *)self.objectToReturn;
}

@end
