//
// Created by yaakaito on 2013/03/21.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FMCounter.h"

@interface FMCounter ()
@property (nonatomic) NSInteger desire;
@property (nonatomic) NSInteger moment;
@end

@implementation FMCounter

- (void)updateDesire:(NSUInteger)desire {
    @synchronized (self) {
        self.desire = desire;
    }
}

- (void)increment {
    @synchronized (self) {
        self.moment++;
    }
}

- (BOOL)isReached {
    return self.moment >= self.desire;
}

- (BOOL)isOvered {
    return self.moment > self.desire;
}
@end