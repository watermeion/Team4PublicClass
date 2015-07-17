//
//  HttpHelper.h
//  HttpHelper
//
//  Created by 胡 帅 on 15/7/15.
//  Copyright (c) 2015年 none. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const int T4_HTTP_NETCOULDNOTACCESS_ERRORCODE;
extern NSString *const T4_HTTP_NETCOULDNOTACCESS_MESSAGE;
/*
 * Http Method
 *
 */
typedef NS_ENUM(NSUInteger, T4HTTPMethod)
{
    Get,
    Post,
    Put,
    Delete
};
/**
 *  T4HttpHelper header file
 */
@interface T4HttpHelper : NSObject

+ (BOOL)isConnectionOK;
+ (BOOL)isWiFiOK;

+ (void)connectAPIPath:(NSString *)apiPath submitParam:(NSDictionary *)paraDic httpMethod:(T4HTTPMethod)method
          successBlock:( void (^)(NSDictionary *responseDic)) successBlock errorBlock:( void (^)(NSError *error)) errorBlock;
@end
