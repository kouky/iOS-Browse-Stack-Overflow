//
//  FakeAnswerBuilder.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnswerBuilder.h"

@class Question;

@interface FakeAnswerBuilder : AnswerBuilder

@property (strong) NSString *receivedJSON;
@property (strong) Question *questionToFill;
@property (strong) NSError *error;
@property BOOL successful;

@end
