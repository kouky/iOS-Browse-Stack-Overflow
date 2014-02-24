//
//  FakeGravatarDelegate.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 24/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FakeGravatarDelegate.h"

@implementation FakeGravatarDelegate

- (void)communicatorReceivedData:(NSData *)data forURL:(NSURL *)url
{
  self.reportedURL = url;
  self.reportedData = data;
}

- (void)communicatorGotErrorForURL:(NSURL *)url
{
  self.reportedURL = url;
}

@end
