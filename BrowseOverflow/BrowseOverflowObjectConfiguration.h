//
//  BrowseOverflowConfiguration.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StackOverflowManager;
@class AvatarStore;

@interface BrowseOverflowObjectConfiguration : NSObject

- (StackOverflowManager *)stackOverflowManager;
- (AvatarStore *)avatarStore;

@end
