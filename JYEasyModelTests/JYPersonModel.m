//
//  JYPersonModel.m
//  JYEasyModel
//
//  Created by BooleanMac on 16/2/8.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import "JYPersonModel.h"

@implementation JYPersonModel : NSObject

+ (NSArray *)JYWhiteList {
    NSArray *result = @[@"age"];
//    NSLog(@"-------------> WHITELIST: %p <-------------", result);
    return result;
}

+ (NSArray *)JYBlackList {
    return @[];
}

+ (NSDictionary *)JYModelMap {
    NSDictionary *result = @{
                             @"age" : @"hello_age",
                             @"name" : @"hello_name"
                             };
//    NSLog(@"-------------> MODELMAP: %p <-------------", result);
    return result;
}

@end
