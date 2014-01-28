//
//  AnswerTests.m
//  BrowseOverflow
//
//  Created by Michael Koukoullis on 28/01/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Answer.h"
#import "Person.h"

@interface AnswerTests : XCTestCase {
    Answer *answer;
    Answer *otherAnswer;
}
@end

@implementation AnswerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    answer = [[Answer alloc] init];
    answer.text = @"The answer is 42";
    answer.person = [[Person alloc] initWithName:@"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    answer.score = 42;
    
    otherAnswer = [[Answer alloc] init];
    otherAnswer.text = @"I have the answer you need";
    otherAnswer.score = 42;
}

- (void)tearDown
{
    answer = nil;
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testAnswerHasSomeText
{
    XCTAssertEqualObjects(answer.text, @"The answer is 42", @"Answer needs to contain some text");
}

- (void)testSomeoneProvideTheAnswer
{
    XCTAssertTrue([answer.person isKindOfClass:[Person class]], @"A Person gave this answer");
}

- (void)testAnswersNotAcceptedByDefault
{
    XCTAssertFalse(answer.accepted, @"Answer not accepted by default");
}

- (void)testAnswerCanBeAccepted
{
    XCTAssertNoThrow(answer.accepted = YES, @"It is possible to accept an answer");
}

- (void)testAnswerHasScore
{
    XCTAssertEqual(answer.score, 42, @"Answer's score can be retrived");
}

- (void)testAcceptedAnswerComesBeforeUnaccepted
{
    otherAnswer.accepted = YES;
    
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending, @"Accepted answer should come first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending, @"Unaccepted answer should come last");
}

- (void)testAnswersWithEqualScoresCompareEqually
{
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedSame, @"Both answers if equal rank");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedSame, @"Each answer has the same rank");
    
}

- (void)testLowerScoringAnswerComesAfterHigher
{
    otherAnswer.score = answer.score + 10;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending, @"Higher score comes first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending, @"Loer score comes last");

}
@end
