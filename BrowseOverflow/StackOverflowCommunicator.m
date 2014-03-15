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
  [self fetchContentAtURL:[NSURL URLWithString:
                           [NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/search?tagged=%@&pagesize=20", tag]]
             errorHandler: ^(NSError *error) {
                [self.delegate searchingForQuestionsFailedWithError:error];
             }
           successHandler: ^(NSString *objectNotation) {
                [self.delegate receivedQuestionsJSON: objectNotation];
           }];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)questionID
{
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/questions/%ld?body=true", (long)questionID]]
               errorHandler: ^(NSError *error) {
                  [self.delegate fetchingQuestionBodyFailedWithError:error];
               }
             successHandler:^(NSString *objectNotation) {
                  [self.delegate receivedQuestionBodyJSON: objectNotation];
             }];
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)questionID
{
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/questions/%ld/answers?body=true", (long)questionID]]
               errorHandler: ^(NSError *error) {
                  [self.delegate fetchingAnswersFailedWithError:error];
               }
             successHandler:^(NSString *objectNotation) {
                  [self.delegate receivedAnswerListJSON: objectNotation];
             }];
}

#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

    if ([httpResponse statusCode] != 200) {
        NSError *error = [NSError errorWithDomain:StackOverflowCommunicatorErrorDomain code:[httpResponse statusCode] userInfo:nil];
        errorHandler(error);
        [self cancelAndDiscardURLConnection];
    }
    else {
      receivedData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    receivedData = nil;
    fetchingConnection = nil;
    fetchingURL = nil;
    errorHandler(error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    fetchingConnection = nil;
    fetchingURL = nil;
    NSString *receivedText = [[NSString alloc] initWithData: receivedData
                                                   encoding: NSUTF8StringEncoding];
    receivedData = nil;
    successHandler(receivedText);
}

#pragma mark Private

- (void)launchConnectionForRequest: (NSURLRequest *)request
{
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)fetchContentAtURL:(NSURL *)url errorHandler:(void (^)(NSError *))errorBlock successHandler:(void (^)(NSString *))successBlock
{
    fetchingURL = url;
    errorHandler = [errorBlock copy];
    successHandler = [successBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    
    [self launchConnectionForRequest:request];
}


- (void)cancelAndDiscardURLConnection
{
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

@end

NSString *StackOverflowCommunicatorErrorDomain = @"StackOverflowCommunicatorErrorDomain";
