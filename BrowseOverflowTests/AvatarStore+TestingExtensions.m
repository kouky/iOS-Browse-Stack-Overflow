//
//  AvatarStore+TestingExtensions.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 24/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "AvatarStore+TestingExtensions.h"

@implementation AvatarStore (TestingExtensions)

- (void)setData:(NSData *)data forLocation:(NSString *)location
{
  [dataCache setObject: data forKey: location];
}

- (NSUInteger)dataCacheSize
{
  return [[dataCache allKeys] count];
}

- (NSDictionary *)communicators
{
  return communicators;
}

- (NSNotificationCenter *)notificationCenter
{
  return notificationCenter;
}

@end
