//
//  Answer.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "Answer.h"

@implementation Answer

- (NSComparisonResult)compare:(Answer *)otherAnswer
{
    if (self.accepted && !otherAnswer.accepted)
        return NSOrderedAscending;
    else if (!self.accepted && otherAnswer.accepted)
        return NSOrderedDescending;
    
    if (self.score > otherAnswer.score)
        return NSOrderedAscending;
    else if (self.score < otherAnswer.score)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}


@end
