//
//  Topic.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 26/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Question;

@interface Topic : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *tag;

- (id)initWithName:(NSString *)name tag:(NSString *)tag;
- (NSArray *)recentQuestions;
- (void)addQuestion:(Question *)question;

@end
