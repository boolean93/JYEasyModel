//
//  NSDictionary+JYEasyModel.m
//  JYEasyModel
//
//  Created by BooleanMac on 16/4/17.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import "NSDictionary+JYEasyModel.h"
#import "NSObject+JYEasyModel.h"
#import "JYPropertyMeta.h"

NS_INLINE JYTypeEncoding getTypeEncodingForClass(Class cls) {
    if (cls == nil) {   // 剪枝
        return JYTypeEncodingNSUnknown;
    }

    if ([cls isSubclassOfClass:NSMutableArray.class]) return JYTypeEncodingNSMutableArray;
    if ([cls isSubclassOfClass:NSMutableString.class]) return JYTypeEncodingNSMutableString;
    if ([cls isSubclassOfClass:NSMutableDictionary.class]) return JYTypeEncodingNSMutableDict;
    if ([cls isSubclassOfClass:NSMutableSet.class]) return JYTypeEncodingNSMutableSet;
    if ([cls isSubclassOfClass:NSMutableData.class]) return JYTypeEncodingNSMutableData;

    if ([cls isSubclassOfClass:NSArray.class]) return JYTypeEncodingNSArray;
    if ([cls isSubclassOfClass:NSString.class]) return JYTypeEncodingNSString;
    if ([cls isSubclassOfClass:NSDictionary.class]) return JYTypeEncodingNSDict;
    if ([cls isSubclassOfClass:NSSet.class]) return JYTypeEncodingNSSet;
    if ([cls isSubclassOfClass:NSData.class]) return JYTypeEncodingNSData;

    if ([cls isSubclassOfClass:NSDate.class]) return JYTypeEncodingNSDate;
    if ([cls isSubclassOfClass:NSDecimalNumber.class]) return JYTypeEncodingNSDecimalNumber;
    if ([cls isSubclassOfClass:NSNumber.class]) return JYTypeEncodingNSNumber;
    if ([cls isSubclassOfClass:NSURL.class]) return JYTypeEncodingNSURL;
    if ([cls isSubclassOfClass:NSValue.class]) return JYTypeEncodingNSValue;

    return JYTypeEncodingNSUnknown;
}

@implementation NSDictionary (JYEasyModel)

- (nullable id)matchedValueForProperty:(JYPropertyMeta * _Nonnull)property {
    // TODO: 自定义字段映射
    id matchedValue = [self valueForKey:property.propertyName];

    // 类型相同直接通过
    if ([matchedValue isKindOfClass:property.cls]) {
        return matchedValue;
    }

    // 继续检查类型问题
    JYTypeEncoding propertyType = property.type;
    JYTypeEncoding valueType = getTypeEncodingForClass(object_getClass(matchedValue));
    if ([JYPropertyMeta canMatchFrom:valueType to:propertyType]) {
        return matchedValue;
    }
    return nil;
}

@end
