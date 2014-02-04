//
//  FakeQuestionBuilder.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "QuestionBuilder.h"

@interface FakeQuestionBuilder : QuestionBuilder
@property (nonatomic, copy) NSString *JSON;
@property (nonatomic, copy) NSArray *arrayToReturn;
@property (nonatomic, copy) NSError *errorToSet;
@property (nonatomic) Question *questionToFill;
@end
