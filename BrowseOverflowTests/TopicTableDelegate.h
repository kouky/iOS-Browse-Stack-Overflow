//
//  EmptyTableViewDelegate.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicTableDataSource.h"

@interface TopicTableDelegate : NSObject <UITableViewDelegate>

@property (nonatomic, strong) TopicTableDataSource *tableDataSource;

@end

extern NSString *TopicTableDidSelectTopicNotification;