//
//  Connect.m
//  YaPi
//
//  Created by 曹后红 on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Connect.h"
#import "AFHTTPSessionManager.h"


@implementation Connect

//只需执行一次的线程安全码
+ (Connect *)sharedInstance
{
    static Connect *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)doTestGetNetWorkWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *dataTask, NSDictionary *responseDic))success failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failure
{
    [self doGetWithUrl:url parameters:parameters success:^(NSURLSessionDataTask *dataTask, NSDictionary *responseDic) {
        
        success(dataTask, responseDic);
        
    } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        
        failure(dataTask, error);
    }];
}

- (void)doTestPostNetWorkWithUrl:(NSString *)url parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *dataTask, NSDictionary *responseDic))success failure:(void(^)(NSURLSessionDataTask *dataTask, NSError *error))failure
{
    [self doPostWithUrl:url parameters:parameters success:^(NSURLSessionDataTask *dataTask, NSDictionary *responseDic) {
        
        success(dataTask, responseDic);
        
    } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        
        failure(dataTask, error);
    }];
}


//GET方法
- (void)doGetWithUrl:(NSString *)url
          parameters:(id)parameters
             success:(void (^)(NSURLSessionDataTask *dataTask, NSDictionary *responseDic))success
             failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failure

{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

//POST方法
- (void)doPostWithUrl:(NSString *)url
           parameters:(id)parameters
              success:(void(^)(NSURLSessionDataTask *dataTask, NSDictionary *responseDic))success
              failure:(void(^)(NSURLSessionDataTask *dataTask, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

@end
