//
//  T4_Object.h
//  SuperClass
//
//  Created by 胡 帅 on 15/7/15.
//  Copyright (c) 2015年 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface T4_Object : NSObject

/**
 *  singleton pattern
 *
 *  @return singleton instance
 */
+ (T4_Object *)shareInstance;

/**
 *  convert dictionary 2 object
 *
 *  @param dic  contains values of properties for creating a instance
 *
 *  @return object expresssion of given object
 *
 */
+ (T4_Object *)instanceFromDic:(NSDictionary *)dic;

/**
 *  convert object 2 dictionary
 *
 *  @return dictionary expresssion of current instance
 */
- (NSDictionary *)dictionary;

/**
 *  simple Persistence solution Getter (one record per class)
 *
 *  @return local stored instance
 */
+ (T4_Object *)loadUserDefault;

/**
 *  simple Persistence solution Setter (one record per class)
 *
 *  @param myObject  to be stored
 *
 *
 */
+ (void)saveUserDefault:(T4_Object *)myObject;

/**
 *  clear all values
 *
 *  @return clear object with values of 0 or nil
 */
- (T4_Object *)clear;

@end
