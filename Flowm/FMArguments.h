//
// Created by yaakaito on 2013/03/20.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface FMArguments : NSObject
+ (instancetype)arguments;
- (void)addArgument:(id)value;
- (void)addArgument:(id)value withKey:(NSString *)key;
- (id)argumentAtIndex:(NSUInteger)index;
- (id)argumentForKey:(NSString *)key;
@end