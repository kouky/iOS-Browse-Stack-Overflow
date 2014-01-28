//
//  Person.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithName:(NSString *)name avatarLocation:(NSString *)location
{
    self = [super init];
    if (self) {
        self.name = [name copy];
        self.avatarURL = [[NSURL alloc] initWithString:location];
    }
    return self;
}

@end
