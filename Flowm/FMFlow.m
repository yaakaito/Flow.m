//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FMFlow.h"

@interface FMFlow ()
@property (nonatomic, copy) FlowCompletionBlock completionBlock;
@property (atomic) NSUInteger waits;
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

    return self;
}

- (void)pass {
    self.waits--;
    if (self.waits == 0) {
        self.completionBlock(nil, nil);
    }
}

- (void)extend:(NSUInteger)waits {
    self.waits += waits;
}

@end