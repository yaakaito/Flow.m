//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FMFlow.h"
#import "FMCounter.h"

static NSString *kFlowDomain = @"org.yaakaito.flow";

@interface FMFlow ()
@property (nonatomic, copy) FlowCompletionBlock completionBlock;
@property (nonatomic, strong) FMCounter *passes;
@property (nonatomic, strong) FMCounter *misses;
@property (nonatomic, strong) FMArguments *arguments;
@end

@implementation FMFlow {

}

+ (instancetype)flowWithWaits:(NSInteger)waits completionBlock:(FlowCompletionBlock)completionBlock {
    return [[self alloc] initWithWait:waits completionBlock:completionBlock];
}

- (instancetype)initWithWait:(NSInteger)waits completionBlock:(FlowCompletionBlock)completionBlock {
    self = [super init];

    if (!self) {
        return nil;
    }

    self.passes = [[FMCounter alloc] init];
    self.misses = [[FMCounter alloc] init];
    self.arguments = [FMArguments arguments];

    self.completionBlock = completionBlock;
    [self.passes updateDesire:waits];

    return self;
}

- (void)pass {

    [self.passes increment];
    if ([self.passes isReached]) {
        self.completionBlock(nil, self.arguments);
    }

}

- (void)passWithValue:(id)value {
    [self.arguments addArgument:value];
    [self pass];
}

- (void)passWithValue:(id)value forKey:(NSString *)key {
    [self.arguments addArgument:value withKey:key];
    [self pass];
}

- (void)extend:(NSInteger)waits {
    [self.passes updateDesire:self.passes.desire + waits];
}

- (NSError *)_failureError {
    return [NSError errorWithDomain:kFlowDomain
                               code:kFMErrorCodeFailure
                           userInfo:nil];
}

- (void)miss {
    [self.misses increment];
    if ([self.misses isOvered]) {
        self.completionBlock([self _failureError], self.arguments);
    }
}

- (void)missable:(NSInteger)misses {
    [self.misses updateDesire:misses];
}

- (NSError *)_exitErrorWithUserInfo:(NSDictionary *)userInfo {
    return [NSError errorWithDomain:kFlowDomain
                               code:kFMErrorCodeExit
                           userInfo:userInfo];
}

- (void)exit:(NSDictionary *)userInfo {
    self.completionBlock([self _exitErrorWithUserInfo:userInfo], self.arguments);
}

@end