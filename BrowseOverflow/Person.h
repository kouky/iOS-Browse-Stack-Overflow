//
//  Person.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *avatarURL;

- (id)initWithName:(NSString *)name avatarLocation:(NSString *)location;

@end
