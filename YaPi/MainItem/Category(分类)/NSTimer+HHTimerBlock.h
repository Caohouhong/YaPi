//
//  NSTimer+HHTimerBlock.h
//  YaPi
//
//  Created by 曹后红 on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (HHTimerBlock)

/**
 *   计时器会保留其目标对象，反复执行任务通常会导致应用程序出问题，简单说，就是容易引入“保留环”。
 *   创建计时器的时候，由于目标对象为self，所以要保留此实例。因为计时器是用实例变量存放的，所以实例也
 *   保留了计时器。于是，产生了“保留环”
 *   可以通过block来解决此问题。
 
 *    计时器的分类，解决保留环问题
 */

+ (NSTimer *) hh_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)())block
                                        repeats:(BOOL)repeats;
@end
