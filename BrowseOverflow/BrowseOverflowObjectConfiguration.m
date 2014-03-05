//
//  BrowseOverflowConfiguration.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "BrowseOverflowObjectConfiguration.h"
#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "QuestionBuilder.h"
#import "AnswerBuilder.h"

@implementation BrowseOverflowObjectConfiguration

- (StackOverflowManager *)stackOverflowManager
{
  StackOverflowManager *manager = [[StackOverflowManager alloc] init];
  manager.communicator = [[StackOverflowCommunicator alloc] init];
  manager.communicator.delegate = manager;
  manager.questionBuilder = [[QuestionBuilder alloc] init];
  manager.answerBuilder = [[AnswerBuilder alloc] init];
  return manager;
}

@end
