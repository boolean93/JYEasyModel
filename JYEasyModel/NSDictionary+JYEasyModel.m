//
//  NSDictionary+JYEasyModel.m
//  JYEasyModel
//
//  Created by BooleanMac on 16/4/17.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import "NSDictionary+JYEasyModel.h"
#import "JYPropertyMeta.h"

@implementation NSDictionary (JYEasyModel)

- (nullable id)matchedValueForProperty:(JYPropertyMeta * _Nonnull)property {
    id matchedValue = [self valueForKey:property.propertyName];
    JYTypeEncoding valueType = [JYPropertyMeta getTypeEncodingForClass:object_getClass(matchedValue)];
    JYTypeEncoding propertyType = property.type;
    if ([self.class canMatchFrom:valueType to:propertyType]) {
        return matchedValue;
    }
    return nil;
}

// TODO: 不同类型的对象之间的判断
+ (BOOL)canMatchFrom:(JYTypeEncoding)fromType to:(JYTypeEncoding)toType {
    if (fromType == toType) {
        return YES;
    }
    return NO;
}

@end
