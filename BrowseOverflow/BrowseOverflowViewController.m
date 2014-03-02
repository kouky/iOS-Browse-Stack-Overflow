//
//  BrowseOverflowViewController.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "BrowseOverflowViewController.h"
#import "QuestionListTableDataSource.h"
#import "QuestionDetailDataSource.h"
#import <objc/runtime.h>

@interface BrowseOverflowViewController ()

@end

@implementation BrowseOverflowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      // Custom initialization
  }
  return self;
}

- (void)userDidSelectTopicNotification:(NSNotification *)note
{
  Topic *selectedTopic = (Topic *)[note object];
  BrowseOverflowViewController *nextViewController = [[BrowseOverflowViewController alloc] init];
  QuestionListTableDataSource *questionsDataSource = [[QuestionListTableDataSource alloc] init];
  questionsDataSource.topic = selectedTopic;
  nextViewController.dataSource = questionsDataSource;
  [[self navigationController] pushViewController:nextViewController animated:YES];
}

- (void)userDidSelectQuestionNotification:(NSNotification *)note
{
  Question *selectedQuestion = (Question *)[note object];
  BrowseOverflowViewController *nextViewController = [[BrowseOverflowViewController alloc] init];
  QuestionDetailDataSource *questionDetailDataSource = [[QuestionDetailDataSource alloc] init];
  questionDetailDataSource.question = selectedQuestion;
  nextViewController.dataSource = questionDetailDataSource;
  [[self navigationController] pushViewController:nextViewController animated:YES];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.tableView.delegate = self.dataSource;
  self.tableView.dataSource = self.dataSource;
  
  // Key value coding doesn't work here?!
  
  // objc_property_t tableViewProperty = class_getProperty([self.dataSource class], "tableView");
  // if (tableViewProperty) {
  //  [self.dataSource setValue: tableView forKey: @"tableView"];
  // }

  // So instead we do this.
  if ([self.dataSource isKindOfClass:[QuestionListTableDataSource class]]) {
    QuestionListTableDataSource *questionListTableDataSource = (QuestionListTableDataSource *)self.dataSource;
    questionListTableDataSource.tableView = self.tableView;
  }
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(userDidSelectTopicNotification:)
                                               name:TopicTableDidSelectTopicNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(userDidSelectQuestionNotification:)
                                               name: QuestionListDidSelectQuestionNotification
                                             object: nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:TopicTableDidSelectTopicNotification
                                                object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:QuestionListDidSelectQuestionNotification
                                                object: nil];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
