//
//  StackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 31/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowCommunicator : NSObject {
@protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
}

- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)downloadInformationForQuestionWithID:(NSInteger)questionID;
- (void)downloadAnswersToQuestionWithID:(NSInteger)questionID;
- (void)cancelAndDiscardURLConnection;

@end
