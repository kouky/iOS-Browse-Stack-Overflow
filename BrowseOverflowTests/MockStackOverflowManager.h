//
//  MockStackOverflowManager.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 5/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

@class Topic;
@class Question;

@interface MockStackOverflowManager : NSObject <StackOverflowCommunicatorDelegate> {
  NSInteger topicFailureErrorCode;
  NSInteger bodyFailureErrorCode;
  NSInteger answerFailureErrorCode;
  NSString *topicSearchString;
  NSString *questionBodyString;
  NSString *answerListString;
  BOOL wasAskedToFetchQuestions;
  BOOL wasAskedToFetchAnswers;
  BOOL wasAskedToFetchBody;
}

- (NSInteger)topicFailureErrorCode;
- (NSInteger)bodyFailureErrorCode;
- (NSInteger)answerFailureErrorCode;
- (NSString *)topicSearchString;
- (NSString *)questionBodyString;
- (NSString *)answerListString;

- (BOOL)didFetchQuestions;
- (BOOL)didFetchQuestionBody;
- (BOOL)didFetchAnswers;
- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchAnswersForQuestion:(Question *)question;

@end
