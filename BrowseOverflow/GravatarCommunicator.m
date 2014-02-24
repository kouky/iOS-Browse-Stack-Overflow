//
//  GravatrCommunicator.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 24/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "GravatarCommunicator.h"

@implementation GravatarCommunicator

- (void)fetchDataForURL:(NSURL *)location
{
  self.url = location;
  NSURLRequest *request = [NSURLRequest requestWithURL: location];
  self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark NSURLConnection Delegate

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  [self.delegate communicatorReceivedData:[self.receivedData copy] forURL:self.url];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  self.receivedData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  [self.delegate communicatorGotErrorForURL:self.url];
}

@end
