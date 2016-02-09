//
//  NSObject+JYEasyModel.m
//  JYEasyModel
//
//  Created by BooleanMac on 16/2/7.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import "NSObject+JYEasyModel.h"
#import <objc/runtime.h>

@implementation NSObject (JYEasyModel)

+ (instancetype)JY_modelWithDictionary:(NSDictionary *)dict{
    id instance = self.new;
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@%@:", @"set", key]);
        if ([instance respondsToSelector:selector]) {
            objc_msgSend(instance, selector, obj);
        }
    }];
    return instance;
}

@end
