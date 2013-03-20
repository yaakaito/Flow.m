//
//  Flowm - FMArgumentsTests.m
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//  Created by: yaakaito
//

#import <SenTestingKit/SenTestingKit.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "FMArguments.h"

@interface FMArgumentsTests : SenTestCase
{
    
}
@end

@implementation FMArgumentsTests


- (void)setUp {
    // Run before each test method
}

- (void)tearDown {
    // Run after each test method
}

- (void)testAddArgument
{
    FMArguments *arguments = [FMArguments arguments];
    [arguments addArgument:@"HOGE"];

    assertThat([arguments argumentAtIndex:0], equalTo(@"HOGE"));
    assertThat([arguments argumentForKey:@"HOGE"], nilValue());
}

- (void)testAddArgumentWithKey
{
    FMArguments *arguments = [FMArguments arguments];
    [arguments addArgument:@"FUGA" withKey:@"key"];

    assertThat([arguments argumentForKey:@"key"], equalTo(@"FUGA"));
    assertThat([arguments argumentAtIndex:0], equalTo(@"FUGA"));
}

- (void)testAddArguments
{
    FMArguments *arguments = [FMArguments arguments];
    [arguments addArgument:@"HOGE"];
    [arguments addArgument:@"FUGA" withKey:@"key"];

    assertThat([arguments argumentAtIndex:0], equalTo(@"HOGE"));
    assertThat([arguments argumentAtIndex:1], equalTo(@"FUGA"));
    assertThat([arguments argumentForKey:@"key"], equalTo(@"FUGA"));
}

- (void)testAddArgumentsWithKeys
{
    FMArguments *arguments = [FMArguments arguments];
    [arguments addArgument:@"FUGA" withKey:@"fuga"];
    [arguments addArgument:@"PIYO" withKey:@"piyo"];

    assertThat([arguments argumentAtIndex:0], equalTo(@"FUGA"));
    assertThat([arguments argumentAtIndex:1], equalTo(@"PIYO"));
    assertThat([arguments argumentForKey:@"fuga"], equalTo(@"FUGA"));
    assertThat([arguments argumentForKey:@"piyo"], equalTo(@"PIYO"));
}

@end
