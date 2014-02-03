//
//  UserBuilder.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "UserBuilder.h"
#import "Person.h"

@implementation UserBuilder

+ (Person *)personFromDictionary:(NSDictionary *)ownerValues
{
    NSString *name = ownerValues[@"display_name"];
    NSString *avatarURL = [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@", ownerValues[@"email_hash"]];
    Person *owner = [[Person alloc] initWithName:name avatarLocation:avatarURL];
    return owner;
}

@end
