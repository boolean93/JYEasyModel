//
//  NSObject+JYEasyModel.m
//  JYEasyModel
//
//  Created by BooleanMac on 16/2/7.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import "NSObject+JYEasyModel.h"
#import "JYClassInfo.h"
#import "JYPropertyMeta.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define JY_OBJC_MSGSEND(x,y,z) ((void (*)(id, SEL, id))(void *) objc_msgSend)(x,y,z);

@implementation NSObject (JYEasyModel)

+ (instancetype)JY_modelWithDictionary:(NSDictionary *)dict{
    id instance = self.new;
    JYClassInfo *classInfo = [JYClassInfo initWithClass:self.class];
    NSArray *properties = classInfo.properties;
    for (JYPropertyMeta *property in properties) {
        id result;
        if ((result = [dict valueForKey:property.propertyName])) {
            JY_OBJC_MSGSEND(instance, property.setterSeletor, result);
        }
    }
    return instance;
}

@end
