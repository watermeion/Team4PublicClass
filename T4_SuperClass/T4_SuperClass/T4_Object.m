//
//  T4_Object.m
//  SuperClass
//
//  Created by 胡 帅 on 15/7/15.
//  Copyright (c) 2015年 none. All rights reserved.
//

#import "T4_Object.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface T4_Object ()

/**
 *  assign value to current instance
 *
 *  @param dic contains values of properties
 */
- (void)p_assignValue:(NSDictionary *)dic;
/**
 *  construct setMethod
 *
 *  @param propertyName
 */
- (SEL) p_setMehodFromKey:(NSString *)propertyName;
/**
 *  read property names
 *
 *
 *  @return list of property names of current class
 */
- (NSArray *)p_getPropertyList;

@end

@implementation T4_Object

/**
 *  store all singletons in a dictionary
 */
static NSMutableDictionary * T4_SuperClass_Singleton_Dic;

#pragma mark - public method

+ (T4_Object *)shareInstance{
    if (T4_SuperClass_Singleton_Dic == nil){
        T4_SuperClass_Singleton_Dic = [@{} mutableCopy];
    }
    
    Class class = [self class];
    NSString *className = NSStringFromClass(class);
    
    if (T4_SuperClass_Singleton_Dic[className] != nil) {
        return T4_SuperClass_Singleton_Dic[className];
    }else{
        T4_Object *instance = [class new];
        T4_SuperClass_Singleton_Dic[className] = instance;
        return instance;
    }
}

+ (T4_Object *)instanceFromDic:(NSDictionary *)dic{
    T4_Object *instance = [[self class] new];
    [instance p_assignValue:dic];
    return instance;
}

- (NSDictionary *)dictionary{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSArray *propertyList     = [self p_getPropertyList];
    
    for (NSString *key in propertyList) {
        id value = [self valueForKey:key];
        if ([value isKindOfClass:[T4_Object class]] && [[value p_getPropertyList] count] > 0){
            [dict setObject:[value dictionary] forKey:key];
        } else{
            if(value != nil){
                [dict setObject:value forKey:key];
            } else{
                [dict setObject:[NSNull null] forKey:key];
            }
        }
    }
    return dict;
}


+ (T4_Object *)loadUserDefault{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey: NSStringFromClass([self class])];
    if(data == nil || [data length] == 0)
        return nil;
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSDictionary *dic             = [unarchiver decodeObjectForKey:NSStringFromClass([self class])];
    return [[self class]instanceFromDic:dic];
}


+ (void)saveUserDefault:(T4_Object *)myObject{
    // FIXME: NSNull null 不符合NSCoding协议，不能直接写入
    NSDictionary *dic         = [myObject dictionary];
    NSMutableData *data       = [NSMutableData dataWithCapacity:0];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:dic forKey:NSStringFromClass([self class])];
    [archiver finishEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:NSStringFromClass([self class])];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


- (T4_Object *)clear{
    // TODO: 深入测试该方法
    @try {
        NSArray *arr = [self p_getPropertyList];
        for (NSString *value in arr) {
            SEL setMethod = [self p_setMehodFromKey:value];
            if ([self respondsToSelector:setMethod])
            {
                int (*action)(id, SEL, int) = (int (*)(id, SEL, int)) objc_msgSend;
                action(self, setMethod, 0);
            }
        }
        
    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }

}

/**
 *  override description of T4_Object
 *
 *  @return dictionary expression
 */
- (NSString *)description
{
    return [[self dictionary]description];
}

#pragma mark - private method

- (void)p_assignValue:(NSDictionary *)dic
{
    for (NSString *key in dic) {
        SEL setMethod = [self p_setMehodFromKey:key];
        
        if ([self respondsToSelector:setMethod]){
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if (dic[key]!=nil) {
                [self performSelector:setMethod withObject:dic[key]];
            } else{
                [self performSelector:setMethod withObject:[NSNull null]];
            }
            #pragma clang diagnostic
        }
    }
}

- (SEL) p_setMehodFromKey:(NSString *)propertyName{
    NSString *capKey       = [NSString stringWithFormat:@"%@%@", [[propertyName substringToIndex:1]capitalizedString], [propertyName substringFromIndex:1]];
    NSString *setCapKey    = [NSString stringWithFormat:@"%@%@",@"set", capKey];
    NSString *setMethodStr = [NSString stringWithFormat:@"%@%@",setCapKey,@":"];
    return NSSelectorFromString(setMethodStr);
}

- (NSArray *)p_getPropertyList
{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    
    for (NSUInteger i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertyArray;
}

@end
