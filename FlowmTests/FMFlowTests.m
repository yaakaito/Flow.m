//
//  Flowm - FMFlowTests.m
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//  Created by: yaakaito
//

#import <SenTestingKit/SenTestingKit.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import "AsyncTestSupporter.h"

#import "FMFlow.h"

@interface FMFlowTests : SenTestCase
{
    AsyncTestSupporter *asyncTest;
}
@end

@implementation FMFlowTests


- (void)setUp {
    asyncTest = [[AsyncTestSupporter alloc] init];
    [asyncTest prepare];
}

- (void)testInitializeAndPass {

    FMFlow *flow = [FMFlow flowWithWait:1 completionBlock:^(NSError *error, NSArray *arguments) {
        [asyncTest notify:kAsyncTestSupporterWaitStatusSuccess];
    }];

    __weak FMFlow *that = flow;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    [asyncTest waitForTimeout:5];
}

- (void)testWait2times {

    FMFlow *flow = [FMFlow flowWithWait:2 completionBlock:^(NSError *error, NSArray *arguments) {
        [asyncTest notify:kAsyncTestSupporterWaitStatusSuccess];
    }];

    __weak FMFlow *that = flow;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    [asyncTest waitForTimeout:5];
}

- (void)testBeShortPasses {
    FMFlow *flow = [FMFlow flowWithWait:2 completionBlock:^(NSError *error, NSArray *arguments) {
        [asyncTest notify:kAsyncTestSupporterWaitStatusSuccess];
    }];

    __weak FMFlow *that = flow;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    STAssertThrows([asyncTest waitForTimeout:1], @"expected timeout");
}

- (void)performAfter2secondsWithFlow:(FMFlow *)aFlow {
    [aFlow pass];
}

- (void)testPerformAfter2seconds {
    FMFlow *flow = [FMFlow flowWithWait:1 completionBlock:^(NSError *error, NSArray *arguments) {
        [asyncTest notify:kAsyncTestSupporterWaitStatusSuccess];
    }];

    [self performSelector:@selector(performAfter2secondsWithFlow:) withObject:flow afterDelay:2];

    [asyncTest waitForTimeout:5];
}
@end
