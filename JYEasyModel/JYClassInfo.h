//
//  JYClassInfo.h
//  JYEasyModel
//
//  Created by BooleanMac on 16/3/31.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYPropertyMeta.h"

@interface JYClassInfo : NSObject

@property (nonatomic, strong) NSArray<JYPropertyMeta *> *properties;

+ (JYClassInfo *)initWithClass:(Class)cls;

@end

@interface JYGlobalInfo : NSObject
+ (NSMutableDictionary *)sharedClasses;
@end