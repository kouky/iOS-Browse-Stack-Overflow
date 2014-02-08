//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 8/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseOverflowViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) id <UITableViewDataSource> dataSource;
@property (nonatomic, strong) id <UITableViewDelegate> tableViewDelegate;

@end
