//
//  UserHelper.m
//  YaPi
//
//  Created by 曹后红 on 16/8/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserHelper.h"

@implementation UserHelper


//时间格式转换
+(NSString *)getHomeFormateIntevalTime:(double)intevalTime
{
    NSMutableString *intevalTimeString = [[NSMutableString alloc]init];
    
    int day = intevalTime/60/60/24;
    //如果大于一天则返回 %d天
    if (day > 1) {
        [intevalTimeString appendString:[NSString stringWithFormat:@"%d天",day]];
        intevalTime = intevalTime - day*24*60*60;
        
    }
    
    int hour = intevalTime/60/60;
    //否则返回 **时**分**秒
    if (hour > 0) {
        [intevalTimeString appendString:[NSString stringWithFormat:@"%d时",hour]];
        intevalTime = intevalTime-hour*60*60;
    }
    
    
    int minite =intevalTime/60;
    if (minite>0) {
        if (minite<10) {
            [intevalTimeString appendString:[NSString stringWithFormat:@"0%d分",minite]];
        }else
        {
            [intevalTimeString appendString:[NSString stringWithFormat:@"%d分",minite]];
        }
        intevalTime = intevalTime-minite*60;
    }else if(hour>0)
    {
        [intevalTimeString appendString:@"00分"];
    }
    
    int second = intevalTime;
    if(second>0)
    {
        if (second<10) {
            [intevalTimeString appendString:[NSString stringWithFormat:@"0%d秒",second]];
        }else
        {
            [intevalTimeString appendString:[NSString stringWithFormat:@"%d秒",second]];
        }
    }else
    {
        [intevalTimeString appendString:@"00秒"];
    }
    
    return intevalTimeString;
}


@end
