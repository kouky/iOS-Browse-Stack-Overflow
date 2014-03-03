//
//  MockStackoverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 31/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator ()
@property (nonatomic, readwrite) BOOL wasAskedToFetchQuestions;
@property (nonatomic, readwrite) BOOL wasAskedToFetchBody;
@end

@implementation MockStackOverflowCommunicator

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    self.wasAskedToFetchQuestions = YES;
}

- (void)downloadInformationForQuestionWithID:(NSInteger)questionID
{
    self.wasAskedToFetchBody = YES;
}

@end
