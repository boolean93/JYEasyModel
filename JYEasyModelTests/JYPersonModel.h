//
//  JYPersonModel.h
//  JYEasyModel
//
//  Created by BooleanMac on 16/2/7.
//  Copyright © 2016年 Boolean93. All rights reserved.
//
#import <JYEasyModel/JYEasyModel.h>

@interface JYPersonModel : NSObject<JYModel>
@property (nonatomic, strong) NSNumber *hello_age;
@property (nonatomic, strong) NSString *hello_name;

+ (NSArray *)JYWhiteList;

+ (NSDictionary *)JYModelMap;
@end
