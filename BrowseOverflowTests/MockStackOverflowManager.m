//
//  MockStackOverflowManager.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 5/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "MockStackOverflowManager.h"
#import "Topic.h"

@implementation MockStackOverflowManager

- (NSInteger)topicFailureErrorCode
{
    return topicFailureErrorCode;
}

- (NSInteger)bodyFailureErrorCode
{
    return bodyFailureErrorCode;
}

- (NSInteger)answerFailureErrorCode
{
    return answerFailureErrorCode;
}

- (NSString *)topicSearchString
{
    return topicSearchString;
}

- (NSString *)questionBodyString
{
    return questionBodyString;
}

- (NSString *)answerListString
{
    return answerListString;
}

- (BOOL)didFetchQuestions
{
  return wasAskedToFetchQuestions;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic
{
  wasAskedToFetchQuestions = YES;
}

- (BOOL)didFetchQuestionBody
{
  return wasAskedToFetchBody;
}

- (void)fetchBodyForQuestion:(Question *)question
{
  wasAskedToFetchBody = YES;
}

- (BOOL)didFetchAnswers
{
  return wasAskedToFetchAnswers;
}

- (void)fetchAnswersForQuestion:(Question *)question
{
  wasAskedToFetchAnswers = YES;
}

// Delegate methods

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    topicFailureErrorCode = [error code];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    bodyFailureErrorCode = [error code];
}

- (void)fetchingAnswersFailedWithError:(NSError *)error {
    answerFailureErrorCode = [error code];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    topicSearchString = objectNotation;
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    questionBodyString = objectNotation;
}

- (void)receivedAnswerListJSON:(NSString *)objectNotation {
    answerListString = objectNotation;
}

@end
