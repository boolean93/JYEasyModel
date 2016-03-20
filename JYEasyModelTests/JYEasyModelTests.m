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

- (NSString *)json {
    return @"{\"Age\":10, \"Name\":\"Hello\"}";
}

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
    NSString *json = @"{\"age\":10}";
    JYPersonModel *model = [JYPersonModel JY_modelFromJSON:json];
    XCTAssert([model.hello_age isEqual:@10]);
}

@end
