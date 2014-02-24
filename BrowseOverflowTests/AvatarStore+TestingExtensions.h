//
//  AvatarStore+TestingExtensions.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 24/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "AvatarStore.h"

@interface AvatarStore (TestingExtensions)

- (void)setData:(NSData *)data forLocation:(NSString *)location;
- (NSUInteger)dataCacheSize;
- (NSDictionary *)communicators;
- (NSNotificationCenter *)notificationCenter;

@end
