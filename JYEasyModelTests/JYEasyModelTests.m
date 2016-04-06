//
//  JYEasyModelTests.m
//  JYEasyModelTests
//
//  Created by BooleanMac on 16/2/7.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JYEasyModel/JYEasyModel.h>

#import "JYPersonModel.h"

@interface JYEasyModelTests : XCTestCase

@end

@implementation JYEasyModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    for (int i = 0; i < 100000; i++) {
        [JYPersonModel JY_modelWithDictionary:@{@"age" : @10}];
    }
//    XCTAssert([model.age isEqual:@10]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    NSDictionary *dict = @{@"age" : @10};
    [self measureBlock:^{

        for (int i = 0; i < 100000; i++) {
            [JYPersonModel JY_modelWithDictionary:dict];
        }
        // Put the code you want to measure the time of here.
    }];
}

@end
