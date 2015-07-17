//
//  T4ObjectTest.m
//  SuperClass
//
//  Created by 胡 帅 on 15/7/15.
//  Copyright (c) 2015年 none. All rights reserved.
//

#import "T4_SuperClass.h"
#import "T4_ObjectMockSubClass.h"



#pragma mark - test

#import "T4_ObjectTest.h"

@implementation T4_ObjectTest


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
- (void)testShareInstance{
    T4_SubObject_1 *subObject1 = (T4_SubObject_1 *)[T4_SubObject_1 shareInstance];
    T4_SubObject_2 *subObject2 = (T4_SubObject_2 *)[T4_SubObject_2 shareInstance];
    
    T4_SubObject_1 *subObject1_fetchAgain = (T4_SubObject_1 *)[T4_SubObject_1 shareInstance];
    T4_SubObject_2 *subObject2_fetchAgain = (T4_SubObject_2 *)[T4_SubObject_2 shareInstance];

    XCTAssertNotEqualObjects(subObject1, subObject2);
    XCTAssertEqualObjects(subObject1, subObject1_fetchAgain);
    XCTAssertEqualObjects(subObject2, subObject2_fetchAgain);
}

// !!!: figure out when would nil and [NSNull null] disappear
- (void)testDic2Instance{
    // full values
    NSDictionary *dic1 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"}};
    NSDictionary *dic2 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"},
                           @"intValue":@1, @"boolValue":@YES, @"floatValue":@1.2f};
    // part missed values
    NSDictionary *dic3 = @{@"name":@"dic1Name"};
    NSDictionary *dic4 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"},
                           @"intValue":@1, @"floatValue":@1.2f};
    // part wrong values
    NSDictionary *dic5 = @{@"named":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"}};
    NSDictionary *dic6 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"},
                           @"intValue":@1, @"boolVaflue":@YES, @"floatValue":@1.2f};
    
    // part [NSNull null] values
    NSDictionary *dic7 = @{@"named":[NSNull null] , @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"}};
    NSDictionary *dic8 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"},
                           @"intValue":@1, @"boolVaflue":[NSNull null] , @"floatValue":@1.2f};

    // create instance
    T4_SubObject_1 * subObject1 = (T4_SubObject_1 * )[T4_SubObject_1 instanceFromDic:dic1];
    T4_SubObject_1 * subObject3 = (T4_SubObject_1 * )[T4_SubObject_1 instanceFromDic:dic3];
    T4_SubObject_1 * subObject5 = (T4_SubObject_1 * )[T4_SubObject_1 instanceFromDic:dic5];
    T4_SubObject_1 * subObject7 = (T4_SubObject_1 * )[T4_SubObject_1 instanceFromDic:dic7];

    T4_SubObject_2 * subObject2 = (T4_SubObject_2 * )[T4_SubObject_2 instanceFromDic:dic2];
    T4_SubObject_2 * subObject4 = (T4_SubObject_2 * )[T4_SubObject_2 instanceFromDic:dic4];
    T4_SubObject_2 * subObject6 = (T4_SubObject_2 * )[T4_SubObject_2 instanceFromDic:dic6];
    T4_SubObject_2 * subObject8 = (T4_SubObject_2 * )[T4_SubObject_2 instanceFromDic:dic8];
    
    // assert
    XCTAssertNotNil(subObject1);
    XCTAssertNotNil(subObject2);
    XCTAssertNotNil(subObject3);
    XCTAssertNotNil(subObject4);
    XCTAssertNotNil(subObject5);
    XCTAssertNotNil(subObject6);
    XCTAssertNotNil(subObject7);
    XCTAssertNotNil(subObject8);
}

- (void)testClear{
    // full values
    NSDictionary *dic1 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"}};
    NSDictionary *dic2 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"},
                           @"intValue":@1, @"boolValue":@YES, @"floatValue":@1.2f};
    // part missed values
    NSDictionary *dic3 = @{@"name":@"dic1Name"};
    NSDictionary *dic4 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"},
                           @"intValue":@1, @"floatValue":@1.2f};
    // part wrong values
    NSDictionary *dic5 = @{@"named":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"}};
    NSDictionary *dic6 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"},
                           @"intValue":@1, @"boolVaflue":@YES, @"floatValue":@1.2f};
    
    // part [NSNull null] values
    NSDictionary *dic7 = @{@"named":[NSNull null] , @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"}};
    NSDictionary *dic8 = @{@"name":@"dic1Name", @"info":@{@"infoKey1":@"infoValue1", @"infoKey2":@"infoValue2"},
                           @"intValue":@1, @"boolVaflue":[NSNull null] , @"floatValue":@1.2f};
    
    // create instance
    T4_SubObject_1 * subObject1 = (T4_SubObject_1 * )[T4_SubObject_1 instanceFromDic:dic1];
    T4_SubObject_1 * subObject3 = (T4_SubObject_1 * )[T4_SubObject_1 instanceFromDic:dic3];
    T4_SubObject_1 * subObject5 = (T4_SubObject_1 * )[T4_SubObject_1 instanceFromDic:dic5];
    T4_SubObject_1 * subObject7 = (T4_SubObject_1 * )[T4_SubObject_1 instanceFromDic:dic7];
    
    T4_SubObject_2 * subObject2 = (T4_SubObject_2 * )[T4_SubObject_2 instanceFromDic:dic2];
    T4_SubObject_2 * subObject4 = (T4_SubObject_2 * )[T4_SubObject_2 instanceFromDic:dic4];
    T4_SubObject_2 * subObject6 = (T4_SubObject_2 * )[T4_SubObject_2 instanceFromDic:dic6];
    T4_SubObject_2 * subObject8 = (T4_SubObject_2 * )[T4_SubObject_2 instanceFromDic:dic8];
    
    [subObject1 clear];
    [subObject2 clear];
    [subObject3 clear];
    [subObject4 clear];
    [subObject5 clear];
    [subObject6 clear];
    [subObject7 clear];
    [subObject8 clear];


}

@end
