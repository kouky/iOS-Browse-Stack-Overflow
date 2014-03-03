//
//  MockStackoverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"

@interface MockStackOverflowManagerDelegate : NSObject <StackOverflowManagerDelegate>
@property (nonatomic) NSError *fetchError;
@property (nonatomic) NSArray *receivedQuestions;
@end
