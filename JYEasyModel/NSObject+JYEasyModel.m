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

#pragma mark - Tool functions
+ (BOOL)_JY_setValue:(id)value usingSetter:(SEL)selector forInstance:(id)instance {
    if ([instance respondsToSelector:selector]) {
        objc_msgSend(instance, selector, value);
        return YES;
    }
    return NO;
}

+ (NSString *)_JY_mappedNameForKey:(NSString *)key withListType:(NSInteger)type {
    switch (type) {
        case 1:
            if (![[self _JY_getWhiteList] containsObject:key]) {
                key = @"";
            }
            break;
        case 2:
            if ([[self _JY_getBlackList] containsObject:key]) {
                key = @"";
            }
            break;
        default:
            break;
    }
    SEL mapSelector = @selector(JYModelMap);
    if ([self respondsToSelector: mapSelector] && key.length > 0) {
        NSDictionary *map = (__bridge NSDictionary *)(__bridge void *)objc_msgSend(self, mapSelector);
        return map[key];
    }
    return key; // 这里感觉不太对
}

+ (NSArray *)_JY_getWhiteList {
    SEL whiteListSEL = @selector(JYWhiteList);
    if ([self respondsToSelector:whiteListSEL]) {
        return (__bridge NSArray *)(__bridge void *)objc_msgSend(self, whiteListSEL);
    }
    return @[];
}

+ (NSArray *)_JY_getBlackList {
    SEL blackListSEL = @selector(JYBlackList);
    if ([self respondsToSelector:blackListSEL]) {
        return (__bridge NSArray *)(__bridge void *)objc_msgSend(self, blackListSEL);
    }
    return @[];
}

+ (NSInteger)_JY_filterListType {
    if ([self _JY_getWhiteList].count > 0) {
        return 1; // WHITE_LIST_TYPE
    }
    if ([self _JY_getBlackList].count > 0) {
        return 2; // BLACK_LIST_TYPE
    }
    return 0; // DEFAULT_LIST_TYPE
}

+ (NSString *)_JY_setterNameForKey:(NSString *)key {
    if (key.length == 0 || key == nil) {
        return @"";
    }
    return ({
        NSString *result = [NSString stringWithFormat:@"%c", [key characterAtIndex:0]];
        result = [NSString stringWithFormat:@"set%@%@:", result.uppercaseString, [key substringFromIndex:1]];
        result;
    });
}

#pragma mark - implementation of those in header file

+ (instancetype)JY_modelFromDictionary:(NSDictionary *)dict {
    NSInteger listType = [self _JY_filterListType];
    id instance = self.new;
    // TODO: 枚举效率应该可以优化
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *mappedKey = [self _JY_mappedNameForKey:key withListType:listType];
        NSString *setterName = [self _JY_setterNameForKey:mappedKey];
        if (setterName.length > 0 && setterName != nil) {
            SEL selector = NSSelectorFromString(setterName);
            [self _JY_setValue:obj usingSetter:selector forInstance:instance];
        }
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
