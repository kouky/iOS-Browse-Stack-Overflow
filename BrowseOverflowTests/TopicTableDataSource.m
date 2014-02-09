//
//  EmptyTableViewDataSource.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "TopicTableDataSource.h"

@interface TopicTableDataSource () {
  NSArray *_topics;
}
@end

@implementation TopicTableDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
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

@end
