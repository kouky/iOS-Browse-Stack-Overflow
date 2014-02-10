//
//  EmptyTableViewDelegate.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TopicTableDelegate.h"

@implementation TopicTableDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSNotification *note = [NSNotification notificationWithName:TopicTableDidSelectTopicNotification
                                                       object:[self.tableDataSource topicForIndexPath:indexPath]];
  [[NSNotificationCenter defaultCenter] postNotification:note];
}

@end

NSString *TopicTableDidSelectTopicNotification = @"TopicTableDidSelectTopicNotification";