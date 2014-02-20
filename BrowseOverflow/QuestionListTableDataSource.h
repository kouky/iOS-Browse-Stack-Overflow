//
//  QuestionListTableDataSource.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 20/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;

@interface QuestionListTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (strong) Topic *topic;
@end
