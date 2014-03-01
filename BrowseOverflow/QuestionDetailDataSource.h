//
//  QuestionDetailDataSource.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 1/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;
@class QuestionDetailCell;
@class AnswerCell;
@class AvatarStore;

@interface QuestionDetailDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong) Question *question;
@property (weak) IBOutlet QuestionDetailCell *detailCell;
@property (weak) IBOutlet AnswerCell *answerCell;
@property (strong) AvatarStore *avatarStore;

@end
