//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 30/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "Topic.h"
#import "Question.h"

@interface StackOverflowManager ()
@property (nonatomic) Question *questionNeedingBody;
@end

@implementation StackOverflowManager

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate
{
    if (newDelegate && ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to protocol" userInfo:nil] raise];
    }
    _delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic
{
    [self.communicator searchForQuestionsWithTag:[topic tag]];
}

- (void)fetchBodyForQuestion:(Question *)question
{
    self.questionNeedingBody = question;
    [self.communicator downloadInformationForQuestionWithID:question.questionID];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error
{
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation
{
    NSError *error = nil;
    NSArray *questions = [self.questionBuilder questionsFromJSON:objectNotation error:&error];
    if (!questions) {
        [self tellDelegateAboutQuestionSearchError:error];
    } else {
        [self.delegate didReceiveQuestions:questions];
    }
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error
{
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation
{
    [self.questionBuilder fillInDetailsForQuestion:self.questionNeedingBody fromJSON:objectNotation];
}

// Private

- (void)tellDelegateAboutQuestionSearchError:(NSError *)error
{
    NSDictionary *errorInfo = nil;
    if(error) {
        errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError
                                                   code:StackOverflowManagerErrorQuestionSearchCode
                                               userInfo:errorInfo];
    [self.delegate fetchQuestionsFailedWithError:reportableError];
}

@end

NSString *StackOverflowManagerError = @"StackOverflowManagerError";