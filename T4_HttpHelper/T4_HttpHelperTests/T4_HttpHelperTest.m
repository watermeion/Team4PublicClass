//
//  T4_HttpHelperTest.m
//  HttpHelper
//
//  Created by 胡 帅 on 15/7/16.
//  Copyright (c) 2015年 none. All rights reserved.
//

#import "T4_HttpHelperTest.h"
#import "T4_HttpHelper.h"

@implementation T4_HttpHelperTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
/*
 - (void)testPerformanceExample {
 // This is an example of a performance test case.
 [self measureBlock:^{
 // Put the code you want to measure the time of here.
 }];
 }*/

#pragma mark - customed test
-(void)testAFNetworking{
    NSString *urlPath = @"https://api.app.net/stream/0/posts/stream/global";
    [T4HttpHelper connectAPIPath:urlPath submitParam:nil httpMethod:Get successBlock:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
    }


@end
