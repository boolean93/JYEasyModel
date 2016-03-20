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

+ (BOOL)_JY_setValue:(id)value usingSetter:(SEL)selector forInstance:(id)instance {
    if ([instance respondsToSelector:selector]) {
        objc_msgSend(instance, selector, value);
        return YES;
    }
    return NO;
}

+ (NSString *)_JY_mappedNameForKey:(NSString *)key forInstance:(id)instance {
    SEL mapSelector = NSSelectorFromString(@"JYModelMap");
    if ([instance respondsToSelector: mapSelector]) {
        NSDictionary *map = (__bridge NSDictionary *)(__bridge void *)objc_msgSend(instance, mapSelector);
        return map[key];
    }
    return key;
}

+ (NSString *)_JY_setterNameForKey:(NSString *)key {
    return ({
        NSString *result = [NSString stringWithFormat:@"%c", [key characterAtIndex:0]];
        result = [NSString stringWithFormat:@"set%@%@:", result.uppercaseString, [key substringFromIndex:1]];
        result;
    });
}



+ (instancetype)JY_modelFromDictionary:(NSDictionary *)dict {
    id instance = self.new;
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *mappedKey = [self _JY_mappedNameForKey:key forInstance:instance];
        NSString *setterName = [self _JY_setterNameForKey:mappedKey];
        SEL selector = NSSelectorFromString(setterName);
        [self _JY_setValue:obj usingSetter:selector forInstance:instance];
    }];
    return instance;
}

+ (instancetype)JY_modelFromJSON:(NSString *)jsonString {
    return [self JY_modelFromDictionary: [self JY_dictionaryFromJSON:jsonString]];
}

+ (NSDictionary *)JY_dictionaryFromJSON:(NSString *)jsonString {
    if (jsonString.length <= 0) {
        NSLog(@"WARNING: jsonString(\"%@\") is not the json string", jsonString);
        return @{};
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"ERROR: %@", error);
        return @{};
    }
    return dict;
}
@end
