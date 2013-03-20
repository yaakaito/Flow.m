//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FMArguments.h"

static NSString *kFlowArgument = @"__flow_argument__";

@interface FMArguments ()
@property (nonatomic, strong) NSMutableArray *arguments;
@end

@implementation FMArguments

+ (instancetype)arguments {
    return [[self alloc] init];
}

- (id)init {
    self = [super init];

    if (!self) {
        return nil;
    }

    self.arguments = [NSMutableArray array];

    return self;
}

- (void)addArgument:(id)value {
    [self.arguments addObject:value];
}

- (void)addArgument:(id)value withKey:(NSString *)key {
    [self.arguments addObject:@[kFlowArgument, key, value]];
}

- (id)argumentAtIndex:(NSUInteger)index {
    id argument = [self.arguments objectAtIndex:index];
    if (NO == [argument isKindOfClass:[NSArray class]]) {
        return argument;
    }

    NSArray *flowArgument = (NSArray *)argument;
    if ([flowArgument count] > 0 && [flowArgument[0] isEqual:kFlowArgument]) {
        return flowArgument[2];
    }

    return argument;
}

- (id)argumentForKey:(NSString *)key {
    __block id argument = nil;
    [self.arguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (NO == [obj isKindOfClass:[NSArray class]]) {
            return;
        }

        NSArray *flowArgument = obj;
        if ([obj count] > 0 && [flowArgument[0] isEqual:kFlowArgument] && [flowArgument[1] isEqualToString:key]) {
            argument = flowArgument[2];
            *stop = YES;
        }
    }];

    return argument;
}

@end