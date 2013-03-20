//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "FMArguments.h"

typedef void(^FlowCompletionBlock)(NSError *error, FMArguments *arguments);

@interface FMFlow : NSObject
+ (instancetype)flowWithWaits:(NSUInteger)waits completionBlock:(FlowCompletionBlock)completionBlock;
- (void)pass;
- (void)passWithValue:(id)value;
- (void)passWithValue:(id)value forKey:(NSString *)key;
- (void)extend:(NSUInteger)waits;
@end