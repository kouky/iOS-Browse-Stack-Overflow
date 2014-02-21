//
//  QuestionListTableDataSource.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 20/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "QuestionListTableDataSource.h"
#import "QuestionSummaryCell.h"
#import "Topic.h"
#import "Question.h"
#import "Person.h"

@implementation QuestionListTableDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [[self.topic recentQuestions] count] ?: 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = nil;
  
  if ([self.topic.recentQuestions count]) {
    Question *question = [self.topic.recentQuestions objectAtIndex:indexPath.row];
    self.summaryCell = [tableView dequeueReusableCellWithIdentifier:@"question"];
    if (!self.summaryCell) {
      [[NSBundle bundleForClass:[self class]] loadNibNamed:@"QuestionSummaryCell" owner:self options:nil];
    }
    self.summaryCell.titleLabel.text = question.title;
    self.summaryCell.scoreLabel.text = [NSString stringWithFormat:@"%d", question.score];
    self.summaryCell.nameLabel.text = question.asker.name;
    
    cell = self.summaryCell;
    self.summaryCell = nil;
  } else {
    cell = [tableView dequeueReusableCellWithIdentifier:@"placeholder"];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"placeholder"];
    }
    cell.textLabel.text = @"There was a problem connecting to the network.";
  }
  
  return cell;
}

@end
