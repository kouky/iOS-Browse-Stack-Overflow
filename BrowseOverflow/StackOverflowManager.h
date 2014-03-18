//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"
#import "StackOverflowCommunicatorDelegate.h"

@class StackOverflowCommunicator;
@class Topic;
@class Question;
@class QuestionBuilder;
@class AnswerBuilder;

@interface StackOverflowManager : NSObject <StackOverflowCommunicatorDelegate>

@property (nonatomic, weak) id <StackOverflowManagerDelegate> delegate;
@property (strong) StackOverflowCommunicator *communicator;
@property (strong) StackOverflowCommunicator *bodyCommunicator;
@property (strong) QuestionBuilder *questionBuilder;
@property (strong) AnswerBuilder *answerBuilder;
@property (strong) Question *questionToFill;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;
- (void)fetchAnswersForQuestion:(Question *)question;
- (void)receivedAnswerListJSON:(NSString *)objectNotation;
- (void)fetchingAnswersFailedWithError:(NSError *)error;

@end

extern NSString *StackOverflowManagerError;

enum {
  StackOverflowManagerErrorQuestionSearchCode,
  StackOverflowManagerErrorAnswerFetchCode,
  StackOverflowManagerErrorQuestionBodyFetchCode
};
