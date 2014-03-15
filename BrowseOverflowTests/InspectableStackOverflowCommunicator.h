//
//  InspectableStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 5/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface InspectableStackOverflowCommunicator : StackOverflowCommunicator
- (NSURL *)URLToFetch;
- (NSURLConnection *)currentURLConnection;
- (NSMutableData *)receivedData;
@end
