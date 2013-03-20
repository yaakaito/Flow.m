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

    FMFlow *flow = [FMFlow flowWithWaits:1 completionBlock:^(NSError *error, FMArguments *arguments) {
        [asyncTest notify:kAsyncTestSupporterWaitStatusSuccess];
    }];

    __weak FMFlow *that = flow;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    [asyncTest waitForTimeout:5];
}

- (void)testWait2times {

    FMFlow *flow = [FMFlow flowWithWaits:2 completionBlock:^(NSError *error, FMArguments *arguments) {
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

    FMFlow *flow = [FMFlow flowWithWaits:2 completionBlock:^(NSError *error, FMArguments *arguments) {
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

    FMFlow *flow = [FMFlow flowWithWaits:1 completionBlock:^(NSError *error, FMArguments *arguments) {
        [asyncTest notify:kAsyncTestSupporterWaitStatusSuccess];
    }];

    [self performSelector:@selector(performAfter2secondsWithFlow:) withObject:flow afterDelay:2];

    [asyncTest waitForTimeout:5];
}

- (void)testExtend {

    FMFlow *flow = [FMFlow flowWithWaits:1 completionBlock:^(NSError *error, FMArguments *arguments) {
        [asyncTest notify:kAsyncTestSupporterWaitStatusSuccess];
    }];

    [flow extend:1];

    __weak FMFlow *that = flow;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    [asyncTest waitForTimeout:5];
}

- (void)testExtend2times {

    FMFlow *flow = [FMFlow flowWithWaits:1 completionBlock:^(NSError *error, FMArguments *arguments) {
        [asyncTest notify:kAsyncTestSupporterWaitStatusSuccess];
    }];

    [flow extend:1];

    __weak FMFlow *that = flow;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    [flow extend:1];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [that pass];
    });

    [asyncTest waitForTimeout:5];
}


@end
