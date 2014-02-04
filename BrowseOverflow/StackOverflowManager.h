//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"
#import "QuestionBuilder.h"

@class StackOverflowCommunicator;
@class Topic;
@class Question;

@interface StackOverflowManager : NSObject

@property (nonatomic, weak) id <StackOverflowManagerDelegate> delegate;
@property (nonatomic, strong) StackOverflowCommunicator *communicator;
@property (nonatomic, strong) QuestionBuilder *questionBuilder;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;

@end

extern NSString *StackOverflowManagerError;

enum {
    StackOverflowManagerErrorQuestionSearchCode
};
