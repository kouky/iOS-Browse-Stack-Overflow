//
//  AvatarStore.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 22/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GravatarCommunicatorDelegate.h"

@interface AvatarStore : NSObject <GravatarCommunicatorDelegate> {
  NSMutableDictionary *dataCache;
  NSMutableDictionary *communicators;
  NSNotificationCenter *notificationCenter;
}

- (NSData *)dataForURL: (NSURL *)url;
- (void)didReceiveMemoryWarning: (NSNotification *)note;
- (void)useNotificationCenter: (NSNotificationCenter *)center;
- (void)stopUsingNotificationCenter: (NSNotificationCenter *)center;
@end

extern NSString *AvatarStoreDidUpdateContentNotification;
