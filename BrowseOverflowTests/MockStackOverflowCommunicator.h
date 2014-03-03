//
//  MockStackoverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 31/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator : StackOverflowCommunicator
@property (nonatomic, readonly) BOOL wasAskedToFetchQuestions;
@property (nonatomic, readonly) BOOL wasAskedToFetchBody;
@end
