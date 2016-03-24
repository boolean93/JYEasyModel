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
    return @[@"age"];
}

+ (NSArray *)JYBlackList {
    return @[];
}

+ (NSDictionary *)JYModelMap {
    return @{
             @"age" : @"hello_age",
             @"name" : @"hello_name"
             };
}

@end
