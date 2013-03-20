//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

typedef void(^FlowCompletionBlock)(NSError *error, NSArray *arguments);

@interface FMFlow : NSObject
+ (instancetype)flowWithWait:(NSUInteger)wait completionBlock:(FlowCompletionBlock)completionBlock;
- (void)pass;
@end