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
@property (nonatomic, strong) NSNumber *number;
@end

@implementation JYEasyModelTests

- (void)testObject {
    Class cls = JYPersonModel.class;
    NSLog(@"-------------------%s", object_getClassName(cls));
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNormalSample {
    JYPersonModel *model = [JYPersonModel JY_modelFromDictionary:@{@"age" : @10}];
    XCTAssert([model.hello_age isEqual:@10]);
}

- (void)testJsonSample {
    NSDictionary *dict = @{
                           @"age" : @10,
                           @"name" : @"Boolean93"
                           };
    JYPersonModel *model = [JYPersonModel JY_modelFromDictionary:dict];
    XCTAssert([model.hello_age isEqual:@10]);
    XCTAssert(![model.hello_name isEqual:@"Boolean93"]);
}

@end