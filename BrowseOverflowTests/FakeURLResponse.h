//
//  FakeURLResponse.h
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 5/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeURLResponse : NSObject {
    NSInteger statusCode;
}

- (id)initWithStatusCode:(NSInteger)code;
- (NSInteger)statusCode;

@end