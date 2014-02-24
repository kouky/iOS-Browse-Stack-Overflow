//
//  FakeGravatarDelegate.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 24/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GravatarCommunicatorDelegate.h"

@interface FakeGravatarDelegate : NSObject <GravatarCommunicatorDelegate>

@property (strong) NSURL *reportedURL;
@property (strong) NSData *reportedData;

@end
