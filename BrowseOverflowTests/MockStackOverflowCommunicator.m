//
//  MockStackoverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 31/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator {
  BOOL wasAskedToFetchQuestions;
  BOOL wasAskedToFetchBody;
  NSInteger questionID;
}

- (id)init {
  if ((self = [super init])) {
    questionID = NSNotFound;
  }
  return self;
}

- (void)searchForQuestionsWithTag:(NSString *)tag
{
  wasAskedToFetchQuestions = YES;
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier
{
  wasAskedToFetchBody = YES;
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier
{
  questionID = identifier;
}

- (BOOL)wasAskedToFetchQuestions
{
  return wasAskedToFetchQuestions;
}

- (BOOL)wasAskedToFetchBody
{
  return wasAskedToFetchBody;
}

- (NSInteger)askedForAnswersToQuestionID
{
  return questionID;
}

@end
