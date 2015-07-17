//
//  T4_ObjectMockSubClass.h
//  SuperClass
//
//  Created by 胡 帅 on 15/7/15.
//  Copyright (c) 2015年 none. All rights reserved.
//

/**
 *  mock model 1 contains only NS objects
 */
@interface T4_SubObject_1 : T4_Object

@property (nonatomic, copy  ) NSString     *name;
@property (nonatomic, strong) NSDictionary *info;

@end

@implementation T4_SubObject_1

@end
/**
 *  mock model 2 contains NS objects and elementary type
 */
@interface T4_SubObject_2 : T4_Object

@property (nonatomic, copy  ) NSString     *name;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, assign) int          intValue;
@property (nonatomic, assign) bool         boolValue;
@property (nonatomic, assign) float        floatValue;

@end

@implementation T4_SubObject_2

@end
