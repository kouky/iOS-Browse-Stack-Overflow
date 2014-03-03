//
//  MockStackoverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate

- (void)fetchQuestionsFailedWithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions
{
    self.receivedQuestions = questions;
}

@end
