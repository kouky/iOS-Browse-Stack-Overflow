//
//  Topic.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 26/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

@interface Topic ()
@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) NSString *tag;
@property (nonatomic, readwrite) NSArray *questions;
@end

@implementation Topic

- (id)initWithName:(NSString *)name tag:(NSString *)tag
{
    self = [super init];
    if (self) {
        self.name = [name copy];
        self.tag = tag;
        self.questions = @[];
    }
    return self;
}

- (NSArray *)sortQuestionsLatestFirst:(NSArray *)questionLIst
{
    return [questionLIst sortedArrayUsingComparator: ^(id obj1, id obj2) {
        Question *q1 = (Question *)obj1;
        Question *q2 = (Question *)obj2;
        return [q2.date compare: q1.date];
    }];
}

- (NSArray *)recentQuestions
{
    return [self sortQuestionsLatestFirst:self.questions];
}

- (void)addQuestion:(Question *)question
{
    NSArray *newQuestions = [self.questions arrayByAddingObject:question];
    if ([newQuestions count] > 20) {
        newQuestions = [self sortQuestionsLatestFirst:newQuestions];
        newQuestions = [newQuestions subarrayWithRange:NSMakeRange(0, 20)];
    }
    self.questions = newQuestions;
}

@end
