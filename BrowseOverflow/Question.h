//
//  Question.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Answer;

@interface Question : NSObject
@property (nonatomic) NSDate *date;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) NSInteger score;
@property (nonatomic, readonly) NSArray *answers;

- (void)addAnswer:(Answer *)answer;
@end
