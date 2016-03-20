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

+ (void)JY_setValue:(id)value usingSetter:(SEL)selector forInstance:(id)instance {
    if ([instance respondsToSelector:selector]) {
        objc_msgSend(instance, selector, value);
    }
}

+ (NSString *)JY_mappedNameForKey:(NSString *)key forInstance:(id)instance {
    SEL mapSelector = NSSelectorFromString(@"JYModelMap");
    if ([instance respondsToSelector: mapSelector]) {
        NSDictionary *map = (__bridge NSDictionary *)(__bridge void *)objc_msgSend(instance, mapSelector);
        return map[key];
    }
    return @"Nothing";
}

+ (instancetype)JY_modelFromDictionary:(NSDictionary *)dict useMapping:(BOOL)useMapping {
    id instance = self.new;
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *mappedKey = [self JY_mappedNameForKey:key forInstance:instance].mutableCopy;
        mappedKey = [NSString stringWithFormat:@"%@%@",
                     [NSString stringWithFormat:@"%c", [mappedKey characterAtIndex:0]]
                     .uppercaseString, [mappedKey substringFromIndex:1]];
        NSString *setterName = [NSString stringWithFormat:@"set%@:", mappedKey];
        SEL selector = NSSelectorFromString(setterName);
        [self JY_setValue:obj usingSetter:selector forInstance:instance];
    }];
    return instance;
}

+ (instancetype)JY_modelFromDictionary:(NSDictionary *)dict {
    return [self JY_modelFromDictionary:dict useMapping:NO];
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
