//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FakeQuestionBuilder.h"

@implementation FakeQuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    self.JSON = objectNotation;
    if (error) {
        *error = self.errorToSet;
    }
    return self.arrayToReturn;
}

@end
