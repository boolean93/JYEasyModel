//
//  NSObject+JYEasyModel.h
//  JYEasyModel
//
//  Created by BooleanMac on 16/2/7.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JYEasyModel)

+ (instancetype)JY_modelFromDictionary:(NSDictionary *)dict;

+ (instancetype)JY_modelFromJSON:(NSString *)jsonString;

+ (NSDictionary *)JY_dictionaryFromJSON:(NSString *)jsonString;

+ (NSString *)JY_mappedNameForKey:(NSString *)key forInstance:(id)instance;

@end
