//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FMFlow.h"

static NSString *kFlowDomain = @"org.yaakaito.flow";

@interface FMFlow ()
@property (nonatomic, copy) FlowCompletionBlock completionBlock;
@property (nonatomic) NSInteger waits;
@property (nonatomic) NSInteger passes;
@property (nonatomic) NSInteger misses;
@property (nonatomic, strong) FMArguments *arguments;
@end

@implementation FMFlow {

}

+ (instancetype)flowWithWaits:(NSInteger)waits completionBlock:(FlowCompletionBlock)completionBlock {
    return [[self alloc] initWithWait:waits completionBlock:completionBlock];
}

- (instancetype)initWithWait:(NSInteger)wait completionBlock:(FlowCompletionBlock)completionBlock {
    self = [super init];

    if (!self) {
        return nil;
    }

    self.waits = wait;
    self.passes = 0;
    self.misses = 0;
    self.completionBlock = completionBlock;
    self.arguments = [FMArguments arguments];

    return self;
}

- (void)pass {
    @synchronized (self) {
        self.passes++;
        if (self.passes == self.waits) {
            self.completionBlock(nil, self.arguments);
        }
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
    @synchronized (self) {
        self.waits += waits;
    }
}

- (NSError *)_failureError {
    return [NSError errorWithDomain:kFlowDomain
                               code:kFMErrorCodeFailure
                           userInfo:nil];
}

- (void)miss {
    @synchronized (self) {
        self.misses--;
        if (self.misses < 0) {
            self.completionBlock([self _failureError], self.arguments);
        }
    }
}

- (void)missable:(NSInteger)misses {
    @synchronized (self) {
        self.misses = misses;
    }
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