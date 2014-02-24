//
//  ReloadDataWatcher.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 22/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "ReloadDataWatcher.h"

@interface ReloadDataWatcher () {
    BOOL didReloadData;
}

@end

@implementation ReloadDataWatcher

- (void)reloadData
{
  didReloadData = YES;
}

- (BOOL)didReceiveReloadData
{
  return didReloadData;
}

@end
