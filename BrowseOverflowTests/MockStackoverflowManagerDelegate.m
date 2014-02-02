//
//  MockStackoverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "MockStackoverflowManagerDelegate.h"

@implementation MockStackoverflowManagerDelegate

- (void)fetchQuestionsFailedWithError:(NSError *)error
{
    self.fetchError = error;
}

@end
