//
//  StackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Topic;

@protocol StackOverflowManagerDelegate <NSObject>
- (void)fetchQuestionsFailedWithError:(NSError *)error;

@end
