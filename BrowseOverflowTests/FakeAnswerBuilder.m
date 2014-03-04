//
//  FakeAnswerBuilder.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 3/03/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "FakeAnswerBuilder.h"

@implementation FakeAnswerBuilder

- (BOOL)addAnswersToQuestion:(Question *)question fromJSON:(NSString *)objectNotation error:(NSError **)addError
{
  self.questionToFill = question;
  self.receivedJSON = objectNotation;
  if (addError) {
    *addError = self.error;
  }
  return self.successful;
}

@end
