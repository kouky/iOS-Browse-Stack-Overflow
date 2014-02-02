//
//  MockStackoverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 31/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockStackoverflowCommunicator : NSObject
@property (nonatomic, readonly) BOOL wasAskedToFetchQuestions;
- (void)searchForQuestionsWithTag:(NSString *)tag;
@end
