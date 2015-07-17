//
//  HttpHelper.m
//  HttpHelper
//
//  Created by 胡 帅 on 15/7/15.
//  Copyright (c) 2015年 none. All rights reserved.
//



#import "T4_HttpHelper.h"
#import "AFNetworking.h"

const int T4_HTTP_NET_COULDNTACCESS_ERRORCODE = 103;
NSString *const T4_HTTP_NET_COULDNTACCESS_MESSAGE = @"网络错误";

static bool isFirstNetAccess    = NO;
static bool couldMonitorNetwork = NO;

@implementation T4HttpHelper

+ (BOOL)isConnectionOK{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}
+ (BOOL)isWiFiOK{
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
}

+ (void)connectAPIPath:(NSString *)apiPath submitParam:(NSDictionary *)paraDic httpMethod:(T4HTTPMethod)method
                   successBlock:( void (^)(NSDictionary *responseDic)) successBlock errorBlock:( void (^)(NSError *error)) errorBlock{
    if (isFirstNetAccess == NO) {
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            couldMonitorNetwork = YES;
        }];
        isFirstNetAccess = YES;
    }
    
    BOOL isOK = [[AFNetworkReachabilityManager sharedManager] isReachable];

    if(isOK == NO && couldMonitorNetwork == YES){
        NSError *error = [NSError errorWithDomain:T4_HTTP_NET_COULDNTACCESS_MESSAGE code:T4_HTTP_NET_COULDNTACCESS_ERRORCODE userInfo:nil];
        errorBlock(error);
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    switch (method) {
        case Get:{
            [manager GET:apiPath parameters:paraDic success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                successBlock(obj);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                errorBlock(error);
            }];
            break;
        }
        case Post:{
            [manager POST:apiPath parameters:paraDic success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                successBlock(obj);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                errorBlock(error);
            }];
            break;
        }
        case Put:{
            [manager PUT:apiPath parameters:paraDic success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                successBlock(obj);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                errorBlock(error);
            }];
            break;
        }
        case Delete:{
            [manager DELETE:apiPath parameters:paraDic success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                successBlock(obj);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                errorBlock(error);
            }];
            break;
        }
    }
}

@end
