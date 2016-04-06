//
//  JYClassInfo.m
//  JYEasyModel
//
//  Created by BooleanMac on 16/3/31.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import "JYClassInfo.h"
#import "JYPropertyMeta.h"
#import <objc/message.h>

@implementation JYClassInfo

+ (JYClassInfo *)initWithClass:(Class)cls {
    JYClassInfo *result = [JYGlobalInfo sharedClasses][cls];

    if (result == nil) {
        // Copy propertyList
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        NSMutableArray *propertyList = @[].mutableCopy;
        for (int i = 0; i < count; i++) {
            [propertyList addObject:[JYPropertyMeta metaWithProperty:properties[i]]];
        }

        result = ({
            JYClassInfo *temp = JYClassInfo.new;
            temp.properties = propertyList.copy;
            temp;
        });
    }

    return result;
}

@end

@implementation JYGlobalInfo

+ (NSMutableDictionary *)sharedClasses {
    static NSMutableDictionary<Class, JYClassInfo *> *classes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!classes) {
            classes = NSMutableDictionary.new;
        }
    });
    return classes;
}

@end