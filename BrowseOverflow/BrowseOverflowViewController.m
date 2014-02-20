//
//  BrowseOverflowViewController.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "BrowseOverflowViewController.h"

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
  BrowseOverflowViewController *nextViewController = [[BrowseOverflowViewController alloc] init];
  [[self navigationController] pushViewController:nextViewController animated:YES];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.tableView.delegate = self.dataSource;
  self.tableView.dataSource = self.dataSource;
}

- (void)viewDidAppear:(BOOL)animated
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(userDidSelectTopicNotification:)
                                               name:TopicTableDidSelectTopicNotification
                                             object:nil];
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:TopicTableDidSelectTopicNotification
                                                object:nil];
  [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
