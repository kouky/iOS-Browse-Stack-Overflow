//
//  AnswerBuilder.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface AnswerBuilder : NSObject

- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)error;

@end

extern NSString *AnswerBuilderErrorDomain;

enum {
  AnswerBuilderErrorInvalidJSONError,
  AnswerBuilderErrorMissingDataError,
};