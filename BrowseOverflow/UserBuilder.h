//
//  UserBuilder.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface UserBuilder : NSObject
+ (Person *)personFromDictionary:(NSDictionary *)ownerValues;
@end
