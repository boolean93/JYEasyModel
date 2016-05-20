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
@property (nonatomic, strong) NSMutableDictionary *bigDict;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation JYEasyModelTests

- (void)setUp {
    [super setUp];
    self.dict = @{@"age" : @10, @"array" : @[@"fuck", @2, @3], @"str" : @"hehe"};
//    NSMutableDictionary *bigDict = @{}.mutableCopy;
//    for (int i = 0; i < 1000000; i++) {
//        bigDict[@(i)] = @(i);
//    }
//    self.bigDict = bigDict.copy;
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
        NSArray *keys = self.bigDict.allKeys;
        for (id key in keys) {
            id element = self.bigDict[key];
        }
    }];
}

static void apply(const void *key, const void *value, void *context) {
    NSString *keyString = [NSString stringWithUTF8String:key];
}

- (void)testCFDictionaryLooper {
    [self measureBlock:^{
        CFDictionaryRef cfDic = (__bridge CFDictionaryRef)self.bigDict;
        CFDictionaryApplyFunction(cfDic, apply, nil);
    }];
}

- (void)testEnumerate {
    [self measureBlock:^{
        [self.bigDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

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
