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
#import "NSDictionary+JYEasyModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define JY_OBJC_MSGSEND(x,y,z) ((void (*)(id, SEL, id))(void *) objc_msgSend)(x,y,z);

@implementation NSObject (JYEasyModel)

+ (instancetype)JY_modelWithDictionary:(NSDictionary *)sourceDict{
    id instance = self.new;
    JYClassInfo *classInfo = [JYClassInfo initWithClass:self.class];
    NSArray *properties = classInfo.properties;
    for (JYPropertyMeta *property in properties) {
        id valueToSet = [sourceDict matchedValueForProperty:property];
        if (valueToSet != nil) {
            if (property.type == JYTypeEncodingJYModel) {
                // 递归, 对自定义成员变量的类型进行处理
                valueToSet = [NSClassFromString(property.typeName) JY_modelWithDictionary:valueToSet];
            }
            ((void (*)(id, SEL, id))(void *) property.setterIMP)(instance, property.setterSeletor, valueToSet);
        }
    }
    return instance;
}

- (void)iamjymodel{
    
}
@end
