//
//  NonNetworkedStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 5/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "NonNetworkedStackOverflowCommunicator.h"

@implementation NonNetworkedStackOverflowCommunicator

- (void)launchConnectionForRequest: (NSURLRequest *)request
{
    //No-operation
}

- (void)setReceivedData:(NSData *)data
{
    receivedData = [data mutableCopy];
}

- (NSData *)receivedData
{
    return [receivedData copy];
}

@end
