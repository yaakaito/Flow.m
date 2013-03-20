//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "FMArguments.h"

typedef enum {
    kFMErrorCodeFailure = -999,
    kFMErrorCodeExit    = -998
} FMErrorCode;

typedef void(^FlowCompletionBlock)(NSError *error, FMArguments *arguments);

@interface FMFlow : NSObject
+ (instancetype)flowWithWaits:(NSUInteger)waits completionBlock:(FlowCompletionBlock)completionBlock;
- (instancetype)pass;
- (instancetype)passWithValue:(id)value;
- (instancetype)passWithValue:(id)value forKey:(NSString *)key;
- (instancetype)extend:(NSUInteger)waits;
- (instancetype)miss;
- (instancetype)missable:(NSUInteger)misses;
- (instancetype)exit:(NSDictionary *)userInfo;
@end