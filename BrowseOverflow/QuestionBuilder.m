//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"
#import "UserBuilder.h"

@implementation QuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    NSParameterAssert(objectNotation != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];

    NSDictionary *parsedObject = (id)jsonObject;
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderInvalidJSONError userInfo:nil];
        }
        return nil;
    }
    
    NSArray *questions = parsedObject[@"questions"];
    if (questions == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderMissingDataError userInfo:nil];
        }
        return nil;
    }
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:[questions count]];
    for (NSDictionary *parsedQuestion in questions) {
        Question *thisQuestion = [[Question alloc] init];
        thisQuestion.questionID = [[parsedQuestion objectForKey: @"question_id"] integerValue];
        thisQuestion.date = [NSDate dateWithTimeIntervalSince1970: [[parsedQuestion objectForKey: @"creation_date"] doubleValue]];
        thisQuestion.title = [parsedQuestion objectForKey: @"title"];
        thisQuestion.score = [[parsedQuestion objectForKey: @"score"] integerValue];
        NSDictionary *ownerValues = [parsedQuestion objectForKey: @"owner"];
        thisQuestion.asker = [UserBuilder personFromDictionary:ownerValues];
        [results addObject: thisQuestion];
    }
    
    return [results copy];
}

@end

NSString *QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";