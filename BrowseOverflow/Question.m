//
//  Question.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "Question.h"

@interface Question ()
@property (nonatomic) NSMutableSet *answerSet;
@end


@implementation Question

- (id)init
{
    self = [super init];
    if (self) {
        self.answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer
{
    [self.answerSet addObject:answer];
}


- (NSArray *)answers
{
    return [[self.answerSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

@end
