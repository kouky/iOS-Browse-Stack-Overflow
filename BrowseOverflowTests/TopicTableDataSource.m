//
//  EmptyTableViewDataSource.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TopicTableDataSource.h"
#import "Topic.h"

NSString *topicCellReuseIdentifier = @"Topic";

@interface TopicTableDataSource () {
  NSArray *_topics;
}
@end

@implementation TopicTableDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSParameterAssert([indexPath section] == 0);
  NSParameterAssert([indexPath row] < [_topics count]);
  UITableViewCell *topicCell = [tableView dequeueReusableCellWithIdentifier:topicCellReuseIdentifier];
  if (!topicCell) {
    topicCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topicCellReuseIdentifier];
  }
  topicCell.textLabel.text = [[self topicForIndexPath:indexPath] name];
  return topicCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSParameterAssert(section == 0);
  return [_topics count];
}

- (void)setTopics:(NSArray *)newTopics
{
  _topics = newTopics;
}

- (Topic *)topicForIndexPath:(NSIndexPath *)indexPath
{
  return [_topics objectAtIndex:[indexPath row]];
}

@end