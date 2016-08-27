//
//  Connect.h
//  YaPi
//
//  Created by 曹后红 on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connect : NSObject
+ (Connect *)sharedInstance;

//get
- (void)doTestGetNetWorkWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *dataTask, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failure;

//post
- (void)doTestPostNetWorkWithUrl:(NSString *)url parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *dataTask, NSDictionary *responseDic))success failure:(void(^)(NSURLSessionDataTask *dataTask, NSError *error))failure;

@end
