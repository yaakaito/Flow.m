//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FMFlow.h"

static NSString *kFlowDomain = @"org.yaakaito.flow";

@interface FMFlow ()
@property (nonatomic, copy) FlowCompletionBlock completionBlock;
@property (nonatomic) NSUInteger waits;
@property (nonatomic, strong) FMArguments *arguments;
@end

@implementation FMFlow {

}

+ (instancetype)flowWithWaits:(NSUInteger)waits completionBlock:(FlowCompletionBlock)completionBlock {
    return [[self alloc] initWithWait:waits completionBlock:completionBlock];
}

- (instancetype)initWithWait:(NSUInteger)wait completionBlock:(FlowCompletionBlock)completionBlock {
    self = [super init];

    if (!self) {
        return nil;
    }

    self.waits = wait;
    self.completionBlock = completionBlock;
    self.arguments = [FMArguments arguments];

    return self;
}

- (void)pass {
    @synchronized (self) {
        self.waits--;
        if (self.waits == 0) {
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

- (void)extend:(NSUInteger)waits {
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
    self.completionBlock([self _failureError], self.arguments);
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