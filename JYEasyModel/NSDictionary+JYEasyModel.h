//
//  NSDictionary+JYEasyModel.h
//  JYEasyModel
//
//  Created by BooleanMac on 16/4/17.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JYPropertyMeta;

@interface NSDictionary (JYEasyModel)

- (nullable id)matchedValueForProperty:(JYPropertyMeta * _Nonnull)key;

@end
