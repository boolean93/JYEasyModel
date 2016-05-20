//
//  JYPropertyMeta.m
//  JYEasyModel
//
//  Created by BooleanMac on 16/3/31.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import "JYPropertyMeta.h"
#import "NSObject+JYEasyModel.h"

// 首字母大写并加入 set 前缀和 : 后缀
NS_INLINE NSString *getSetterName(const char *name) {
    return [NSString stringWithFormat:@"set%c%s:", _toupper(name[0]), ++name];
}
NS_INLINE JYTypeEncoding getTypeEncodingForClass(Class cls) {
    if (cls == nil) {   // 剪枝
        return JYTypeEncodingNSUnknown;
    }

    if ([cls isSubclassOfClass:NSArray.class]) return JYTypeEncodingNSArray;
    if ([cls isSubclassOfClass:NSString.class]) return JYTypeEncodingNSString;
    if ([cls isSubclassOfClass:NSDictionary.class]) return JYTypeEncodingNSDict;
    if ([cls isSubclassOfClass:NSData.class]) return JYTypeEncodingNSData;

    if ([cls isSubclassOfClass:NSNumber.class]) return JYTypeEncodingNSNumber;
    if ([cls isSubclassOfClass:NSDate.class]) return JYTypeEncodingNSDate;
    if ([cls isSubclassOfClass:NSURL.class]) return JYTypeEncodingNSURL;

    if ([cls isSubclassOfClass:NSMutableArray.class]) return JYTypeEncodingNSMutableArray;
    if ([cls isSubclassOfClass:NSMutableString.class]) return JYTypeEncodingNSMutableString;
    if ([cls isSubclassOfClass:NSMutableDictionary.class]) return JYTypeEncodingNSMutableDict;
    if ([cls isSubclassOfClass:NSMutableSet.class]) return JYTypeEncodingNSMutableSet;
    if ([cls isSubclassOfClass:NSMutableData.class]) return JYTypeEncodingNSMutableData;

    if ([cls isSubclassOfClass:NSSet.class]) return JYTypeEncodingNSSet;
    if ([cls isSubclassOfClass:NSDecimalNumber.class]) return JYTypeEncodingNSDecimalNumber;
    if ([cls isSubclassOfClass:NSValue.class]) return JYTypeEncodingNSValue;
    return JYTypeEncodingNSUnknown;
}

NS_INLINE JYTypeEncoding getTypeEncodingForAttr(char attr) {
    switch (attr) {
        case 'c':   return JYTypeEncodingChar;
        case 'i':   return JYTypeEncodingInt;
        case 's':   return JYTypeEncodingShort;
        case 'l':   return JYTypeEncodingLong;
        case 'q':   return JYTypeEncodingLongLong;
        case 'C':   return JYTypeEncodingUChar;
        case 'I':   return JYTypeEncodingUInt;
        case 'S':   return JYTypeEncodingUShort;
        case 'L':   return JYTypeEncodingULong;
        case 'Q':   return JYTypeEncodingULongLong;
        case 'f':   return JYTypeEncodingFloat;
        case 'd':   return JYTypeEncodingDouble;
        case 'B':   return JYTypeEncodingBool;
        case 'v':   return JYTypeEncodingVoid;
        case '*':   return JYTypeEncodingCString;
        case ':':   return JYTypeEncodingSEL;
        default:    return JYTypeEncodingUnknown;
    }
}

@implementation JYPropertyMeta

+ (instancetype)metaWithProperty:(objc_property_t)property {
    JYPropertyMeta *instance = self.new;
    instance->_property = property;
    const char *propertyName = property_getName(property);
    instance->_propertyName = [NSString stringWithUTF8String:propertyName];
    instance->_setterName = getSetterName(propertyName);
    instance->_setterSeletor = NSSelectorFromString(instance->_setterName);
    instance->_type = [self getPropertyType:property instance:instance];

    return instance;
}

+ (JYTypeEncoding)getPropertyType:(objc_property_t)property instance:(JYPropertyMeta *)instance {
    char *typeString = property_copyAttributeValue(property, "T");
    unsigned long len = strlen(typeString);
    if (len > 0) {
        if (typeString[0] == '@') {
            char className[len - 2];
            strcpy(className, typeString + 2);
            className[len - 3] = '\0';
            Class cls = objc_getClass(className);
            // TODO: 这里不太好.
            instance->_typeName = [NSString stringWithUTF8String:className];
            instance->_cls = NSClassFromString(instance->_typeName);
            return getTypeEncodingForClass(cls);
        } else {
            return getTypeEncodingForAttr(typeString[0]);
        }
    }
    if ([instance isKindOfJYModel]) {
        return JYTypeEncodingJYModel;
    }
    return JYTypeEncodingUnknown;
}

// TODO: 不同类型的对象之间的判断
+ (BOOL)canMatchFrom:(JYTypeEncoding)fromType to:(JYTypeEncoding)toType {
    // 类型相同
    if (fromType == toType) {
        return YES;
    }
    if (fromType >= 1 << 16 && fromType <= 1 << 29) {
        if (fromType << 1 == toType || fromType >> 1 == toType) {
            return YES;
        }
    }
    if (toType == JYTypeEncodingNSUnknown) {
        return YES;
    }
    return NO;
}

- (BOOL)isKindOfJYModel {
    Class cls = NSClassFromString(self.typeName);
    if ([cls instancesRespondToSelector:@selector(iamjymodel)]) {
        return YES;
    }
    return NO;
}
@end
