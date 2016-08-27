//
//  UserConnect.h
//  YaPi
//
//  Created by 曹后红 on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConnect : NSObject

+ (NSMutableDictionary *)getBaseRequestParams;

//测试接口
+ (void)testUrlRequset:(NSMutableDictionary *)params success:(void (^)(NSURLSessionDataTask *dataTask, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failure;

@end
