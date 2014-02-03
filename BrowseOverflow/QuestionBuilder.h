//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionBuilder : NSObject
- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error;
@end

extern NSString *QuestionBuilderErrorDomain;

enum {
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError
};

