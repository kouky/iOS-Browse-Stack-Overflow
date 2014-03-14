//
//  QuestionDetailDataSource.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 1/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "QuestionDetailDataSource.h"
#import "QuestionDetailCell.h"
#import "AnswerCell.h"
#import "Answer.h"
#import "Question.h"
#import "Person.h"
#import "AvatarStore.h"

enum {
  questionSection = 0,
  answerSection = 1,
  sectionCount
};

@implementation QuestionDetailDataSource

- (NSString *)HTMLStringForSnippet:(NSString *)snippet
{
  return [NSString stringWithFormat: @"<html><head></head><body>%@</body></html>", snippet];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return (section == answerSection) ? [self.question.answers count] : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = nil;
  if (indexPath.section == questionSection) {
    [[NSBundle bundleForClass:[self class]] loadNibNamed: @"QuestionDetailCell" owner:self options:nil];
    [self.detailCell.bodyWebView loadHTMLString: [self HTMLStringForSnippet:self.question.body] baseURL:nil];
    self.detailCell.titleLabel.text = self.question.title;
    self.detailCell.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.question.score];
    self.detailCell.nameLabel.text = self.question.asker.name;
    self.detailCell.avatarView.image = [UIImage imageWithData: [self.avatarStore dataForURL:self.question.asker.avatarURL]];
    cell = self.detailCell;
    self.detailCell = nil;
  }
  else if (indexPath.section == answerSection) {
    Answer *thisAnswer = [self.question.answers objectAtIndex: indexPath.row];
    [[NSBundle bundleForClass:[self class]] loadNibNamed:@"AnswerCell" owner:self options:nil];
    self.answerCell.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)thisAnswer.score];
    self.answerCell.acceptedIndicator.hidden = !thisAnswer.accepted;
    Person *answerer = thisAnswer.person;
    self.answerCell.personName.text = answerer.name;
    self.answerCell.personAvatar.image = [UIImage imageWithData:[self.avatarStore dataForURL:answerer.avatarURL]];
    [self.answerCell.bodyWebView loadHTMLString:[self HTMLStringForSnippet:thisAnswer.text] baseURL: nil];
    cell = self.answerCell;
    self.answerCell = nil;
  }
  else {
    NSParameterAssert(indexPath.section < sectionCount);
  }
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return sectionCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == questionSection) {
    return 276.0f;
  }
  else {
    return 201.0f;
  }
}
@end