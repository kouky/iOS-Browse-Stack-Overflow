//
//  GravatrCommunicator.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 24/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GravatarCommunicatorDelegate.h"

@interface GravatarCommunicator : NSObject <NSURLConnectionDataDelegate>

@property (strong) NSURL *url;
@property (strong) NSMutableData *receivedData;
@property (weak) id <GravatarCommunicatorDelegate> delegate;
@property (weak) NSURLConnection *connection;

- (void)fetchDataForURL:(NSURL *)location;

@end
