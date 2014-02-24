//
//  ReloadDataWatcher.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 22/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReloadDataWatcher : NSObject

- (void)reloadData;
- (BOOL)didReceiveReloadData;

@end
