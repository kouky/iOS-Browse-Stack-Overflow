//
//  MockStackoverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 31/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "MockStackoverflowCommunicator.h"

@interface MockStackoverflowCommunicator ()
@property (nonatomic, readwrite) BOOL wasAskedToFetchQuestions;
@end

@implementation MockStackoverflowCommunicator

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    self.wasAskedToFetchQuestions = YES;
}

@end
