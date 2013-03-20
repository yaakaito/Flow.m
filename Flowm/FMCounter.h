//
// Created by yaakaito on 2013/03/21.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface FMCounter : NSObject
@property (nonatomic, readonly) NSInteger desire;
@property (nonatomic, readonly) NSInteger moment;

- (void)updateDesire:(NSUInteger)desire;
- (void)increment;
- (BOOL)isReached;
- (BOOL)isOvered;
@end