//
//  StackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@protocol StackOverflowManagerDelegate <NSObject>

- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceiveQuestions:(NSArray *)questions;

- (void)fetchingQuestionBodyFailedWithError: (NSError *)error;
- (void)bodyReceivedForQuestion: (Question *)question;

- (void)retrievingAnswersFailedWithError: (NSError *)error;
- (void)answersReceivedForQuestion: (Question *)question;

@end
