//
//  JYPropertyMeta.m
//  JYEasyModel
//
//  Created by BooleanMac on 16/3/31.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import "JYPropertyMeta.h"

@implementation JYPropertyMeta

+ (instancetype)metaWithProperty:(objc_property_t)property {
    JYPropertyMeta *instance = self.new;
    instance->_property = property;
    NSString *temp = [[NSString stringWithUTF8String:property_getName(property)] substringFromIndex:1];
    NSString *capitalizedChar = [NSString stringWithFormat:@"%c", [[NSString stringWithUTF8String:property_getName(property)]  characterAtIndex:0]].capitalizedString;
    instance->_propertyName = [NSString stringWithUTF8String:property_getName(property)];
    instance->_setterSeletor = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", capitalizedChar, temp]);
    return instance;
}

@end
