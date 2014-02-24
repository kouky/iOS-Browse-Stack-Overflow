//
//  GravatarCommunicatorDelegate.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 24/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GravatarCommunicatorDelegate <NSObject>

- (void)communicatorReceivedData:(NSData *)data forURL:(NSURL *)url;
- (void)communicatorGotErrorForURL:(NSURL *)url;

@end
