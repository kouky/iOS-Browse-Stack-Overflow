//
//  FakeNotificationCenter.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 22/02/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FakeNotificationCenter.h"

@implementation FakeNotificationCenter {
  NSMutableDictionary *observers;
  NSMutableArray *notifications;
}

- (id)init
{
  self = [super init];
  if (self) {
    observers = [[NSMutableDictionary alloc] init];
    notifications = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)addObserver: (id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
  [observers setObject:observer forKey:aName];
}

- (void)removeObserver:(id)observer
{
  [[observers copy]  enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    if ([obj isEqual:observer]) {
      [observers removeObjectForKey:key];
    }
  }];
}

- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)obj
{
  [self removeObserver:observer];
}

- (BOOL)hasObject:(id)observer forNotification:(NSString *)aName
{
  return [[observers objectForKey:aName] isEqual:observer];
}

- (void)postNotification:(NSNotification *)notification
{
  [notifications addObject:notification];
}

- (BOOL)didReceiveNotification:(NSString *)name fromObject:(id)obj
{
  for (NSNotification *note in notifications) {
    if ([[note name] isEqualToString:name] && [[note object] isEqual:obj]) {
      return YES;
    }
  }
  return NO;
}

@end
