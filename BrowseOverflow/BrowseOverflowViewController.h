//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicTableDataSource.h"

@class BrowseOverflowObjectConfiguration;

@interface BrowseOverflowViewController : UIViewController

@property (strong) IBOutlet UITableView *tableView;
@property (strong) id <UITableViewDataSource, UITableViewDelegate> dataSource;
@property (strong) BrowseOverflowObjectConfiguration *objectConfiguration;

- (void)userDidSelectTopicNotification:(NSNotification *)note;
- (void)userDidSelectQuestionNotification:(NSNotification *)note;

@end
