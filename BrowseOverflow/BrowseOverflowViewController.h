//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicTableDelegate.h"
#import "TopicTableDataSource.h"

@interface BrowseOverflowViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TopicTableDataSource <UITableViewDataSource> *dataSource;
@property (nonatomic, strong) TopicTableDelegate <UITableViewDelegate> *tableViewDelegate;

@end
