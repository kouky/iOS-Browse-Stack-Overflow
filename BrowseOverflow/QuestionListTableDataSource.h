//
//  QuestionListTableDataSource.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 20/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;
@class QuestionSummaryCell;
@class AvatarStore;

@interface QuestionListTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong) Topic *topic;
@property (weak) IBOutlet QuestionSummaryCell *summaryCell;
@property (strong) AvatarStore *avatarStore;
@property (weak) UITableView *tableView;
@property (strong) NSNotificationCenter *notificationCenter;

- (void)registerForUpdatesToAvatarStore:(AvatarStore *)store;
- (void)removeObservationOfUpdatesToAvatarStore:(AvatarStore *)store;
- (void)avatarStoreDidUpdateContent:(NSNotification *)note;

@end
