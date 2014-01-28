//
//  Answer.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

@interface Answer : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic) Person *person;
@property (nonatomic) NSInteger score;
@property (nonatomic, getter = isAccepted) BOOL accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer;

@end
