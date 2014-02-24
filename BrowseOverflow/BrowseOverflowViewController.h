//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicTableDataSource.h"

@interface BrowseOverflowViewController : UIViewController

@property (strong) UITableView *tableView;
@property (strong) id <UITableViewDataSource, UITableViewDelegate> dataSource;

- (void)userDidSelectTopicNotification:(NSNotification *)note;

@end
