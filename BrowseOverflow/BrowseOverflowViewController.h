//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicTableDataSource.h"
#import "StackOverflowManagerDelegate.h"

@class BrowseOverflowObjectConfiguration;
@class StackOverflowManager;

@interface BrowseOverflowViewController : UIViewController <StackOverflowManagerDelegate>

@property (strong) IBOutlet UITableView *tableView;
@property (strong) id <UITableViewDataSource, UITableViewDelegate> dataSource;
@property (strong) BrowseOverflowObjectConfiguration *objectConfiguration;
@property (strong) StackOverflowManager *manager;

- (void)userDidSelectTopicNotification:(NSNotification *)note;
- (void)userDidSelectQuestionNotification:(NSNotification *)note;

@end
