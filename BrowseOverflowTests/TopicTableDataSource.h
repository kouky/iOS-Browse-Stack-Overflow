//
//  EmptyTableViewDataSource.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;

@interface TopicTableDataSource : NSObject <UITableViewDataSource>

- (void)setTopics:(NSArray *)newTopics;
- (Topic *)topicForIndexPath:(NSIndexPath *)indexPath;

@end
