//
//  NSTimer+HHTimerBlock.m
//  YaPi
//
//  Created by 曹后红 on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSTimer+HHTimerBlock.h"

@implementation NSTimer (HHTimerBlock)

+ (NSTimer *) hh_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)())block
                                        repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(hh_block:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)hh_block:(NSTimer *)timer
{
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}



@end
