//
//  UserConnect.m
//  YaPi
//
//  Created by 曹后红 on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserConnect.h"
#include <sys/sysctl.h>
#import "Connect.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UserConnect

/**
 用户中心数据
 */
+ (NSMutableDictionary *)getBaseRequestParams
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    

    [params setObject:@"3" forKey:@"channel"];
    
    //1.10-20之间的随机数
    NSUInteger randomNum = arc4random_uniform(10)+10;
    NSString *randomStr = [NSString stringWithFormat:@"%lu",(unsigned long)randomNum];
    [params setObject:randomStr forKey:@"nonce"];
    
    //2.当前时间戳
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]*1000];
    [params setObject:timeStamp forKey:@"timeStamp"];
    
    [params setObject:APP_VERSION forKey:@"version"];
    
    //手机型号
    NSString *phoneModel = [self platform];
    if (phoneModel != nil) {
        [params setObject:phoneModel forKey:@"phoneModel"];
    }
    
    [params setObject:@"1000" forKey:@"productId"];
    
    [params setObject:@"appstore" forKey:@"subCoopId"];
    
    [params setObject:[self getSinatureValueWithRandom:randomStr andTimeStamp:timeStamp] forKey:@"SignatureValue"];
    
    [params setObject:@"4960" forKey:@"userId"];
   
    return params;
}

+(NSString *)getSinatureValueWithRandom:(NSString *)random andTimeStamp:(NSString *)timeStamp
{
    //2.public-key
    NSString *publicKey = @"1B86E3D36C0044C6825A59CD104A01BC3131AB70EC174F3B8B6C517772C1EE3C";
    
    NSString *shaStr = [NSString stringWithFormat:@"%@%@%@",random,publicKey,timeStamp];
    
    return  [[self sha1:shaStr] uppercaseString];
}

//加密
+ (NSString *) sha1:(NSString *)input {
    
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *outputStr = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        
        [outputStr appendFormat:@"%02x", digest[i]];
        
    }
    
    return outputStr;
}

//获得设备型号
+ (NSString *)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    //iPod
    if ([platform rangeOfString:@"iPod"].length > 0) {
        return @"iPod";
    }
    
    //4
    if ([platform rangeOfString:@"iPhone3"].length > 0) {
        return @"iPhone4";
    }
    
    //4s
    if ([platform rangeOfString:@"iPhone4,1"].length > 0) {
        return @"iPhone4s";
    }
    
    //5
    if ([platform rangeOfString:@"iPhone5,1"].length >0 || [platform rangeOfString:@"iPhone5,2"].length > 0) {
        return @"iPhone5";
    }
    
    //5c
    if ([platform rangeOfString:@"iPhone5,3"].length >0 || [platform rangeOfString:@"iPhone5,4"].length > 0) {
        return @"iPhone5C";
    }
    //5s
    if ([platform rangeOfString:@"iPhone6"].length > 0) {
        return @"iPhone5s";
    }
    
    //6
    if ([platform rangeOfString:@"iPhone7,2"].length > 0) {
        return @"iPhone6";
    }
        
    //6 Plus
    if ([platform rangeOfString:@"iPhone7,1"].length > 0) {
        return @"iPhone6 Plus";
    }
    
    //6s
    if ([platform rangeOfString:@"iPhone8,1"].length > 0) {
        return @"iPhone6s";
    }
    
    //6s Plus
    if ([platform rangeOfString:@"iPhone8,2"].length > 0) {
        return @"iPhone6s Plus";
    }
    
    //7
    if ([platform rangeOfString:@"iPhone9"].length > 0) {
        return @"iPhone7";
    }
    
    //模拟器
    if ([platform rangeOfString:@"x86_64"].length > 0 || [platform rangeOfString:@"i386"].length > 0) {
        return @"Simulator";
    }
    return platform;
}

//测试接口
+ (void)testUrlRequset:(NSMutableDictionary *)params success:(void (^)(NSURLSessionDataTask *dataTask, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failure
{
    Connect *connect = [Connect sharedInstance];
    [connect doTestGetNetWorkWithUrl:@"http://dev.jincenter.com/app/v20/member_cashUI.html" parameters:params success:^(NSURLSessionDataTask *dataTask, NSDictionary *responseDic) {
        success(dataTask, responseDic);
    } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        failure(dataTask, error);
    }];
}

@end


