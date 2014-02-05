//
//  StackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 31/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@implementation StackOverflowCommunicator

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/search?tagged=%@&pagesize=20", tag]]];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)questionID
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/questions/%d?body=true", questionID]]];
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)questionID
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/questions/%d/answers?body=true", questionID]]];
}

// Private

- (void)fetchContentAtURL:(NSURL *)url
{
    fetchingURL = url;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)cancelAndDiscardURLConnection
{
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

@end
