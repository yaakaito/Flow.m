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
    // Run before each test method
    asyncTest = [[AsyncTestSupporter alloc] init];
    [asyncTest prepare];
}

- (void)tearDown {
    // Run after each test method
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

@end
