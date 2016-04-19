//
//  JYPropertyMeta.h
//  JYEasyModel
//
//  Created by BooleanMac on 16/3/31.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "JYTypeEncoding.h"

@interface JYPropertyMeta : NSObject

@property (nonatomic) objc_property_t property;
@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) NSString *setterName;
@property (nonatomic) SEL setterSeletor;
@property (nonatomic) JYTypeEncoding type;

+ (instancetype)metaWithProperty:(objc_property_t)property;

+ (JYTypeEncoding)getPropertyType:(objc_property_t)property;

+ (JYTypeEncoding)getTypeEncodingForClass:(Class)cls;

@end