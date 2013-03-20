//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FMFlow.h"

@interface FMFlow ()
@property (nonatomic, copy) FlowCompletionBlock completionBlock;
@property (atomic) NSUInteger wait;
@end

@implementation FMFlow {

}

+ (instancetype)flowWithWait:(NSUInteger)wait completionBlock:(FlowCompletionBlock)completionBlock {
    return [[self alloc] initWithWait:wait completionBlock:completionBlock];
}

- (instancetype)initWithWait:(NSUInteger)wait completionBlock:(FlowCompletionBlock)completionBlock {
    self = [super init];

    if (!self) {
        return nil;
    }

    self.wait = wait;
    self.completionBlock = completionBlock;

    return self;
}

- (void)pass {
    self.wait--;
    if (self.wait == 0) {
        self.completionBlock(nil, nil);
    }
}

@end