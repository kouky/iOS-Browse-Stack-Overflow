//
//  Question.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;
@class Person;

@interface Question : NSObject
@property (nonatomic) NSDate *date;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic) NSInteger score;
@property (nonatomic, readonly) NSArray *answers;
@property (nonatomic) Person *asker;
@property (nonatomic) NSInteger questionID;

- (void)addAnswer:(Answer *)answer;
@end
