//
//  FakeURLResponse.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 5/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FakeURLResponse.h"

@implementation FakeURLResponse

- (id)initWithStatusCode:(NSInteger)code
{
    if ((self = [super init])) {
        statusCode = code;
    }
    return self;
}

- (NSInteger)statusCode
{
    return statusCode;
}

@end