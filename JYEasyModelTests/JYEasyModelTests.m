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
#import "JYDickModel.h"

@interface JYEasyModelTests : XCTestCase
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation JYEasyModelTests

- (void)setUp {
    [super setUp];
    self.dict = @{@"age" : @10, @"array" : @[@"fuck", @2, @3], @"str" : @"hehe"};
//    self.array = @[].mutableCopy;
//    for (int i = 0; i < 10000000; i++) {
//        [self.array addObject:[NSNumber numberWithInt:i]];
//    }
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    JYPersonModel *model = [JYPersonModel JY_modelWithDictionary:self.dict];
    NSLog(@"%@", model);
}

- (void)testQiantao {
    JYPersonModel *person = [JYPersonModel JY_modelWithDictionary:self.dict];
    JYDickModel *dick = [JYDickModel JY_modelWithDictionary:@{@"person" : self.dict}];
    NSLog(@"%@", dick.person);
    NSLog(@"%@", person);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        for (int i = 0; i < 100000; i++) {
            [JYPersonModel JY_modelWithDictionary:self.dict];
        }
    }];
}

- (void)testForLooper {
    [self measureBlock:^{
        for (NSNumber *number in self.array) {

        }
    }];
}

- (void)testCFArrayLooper {
    [self measureBlock:^{
        CFArrayRef cfArr = (__bridge CFArrayRef)self.array.copy;
        for (int i = 0; i < 10000000; i++) {
            CFArrayGetValueAtIndex(cfArr, i);
        }
//        CFArrayApplyFunction(cfArr, CFRangeMake(0, 10000000), CFArrayApplierFunction applier, nil);
    }];
}

- (void)testEnumerate {
    [self measureBlock:^{
        [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        }];
    }];
}

inline static void enumerateFunction(const void *val, void *context) {

}

- (void)testAAA {
    [self measureBlock:^{
        CFArrayApplyFunction((__bridge CFArrayRef)(self.array), CFRangeMake(0, 10000000), enumerateFunction, nil);
    }];
}
@end
