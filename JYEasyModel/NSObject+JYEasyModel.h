//
//  NSObject+JYEasyModel.h
//  JYEasyModel
//
//  Created by BooleanMac on 16/2/7.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JYEasyModel)

/**
 *  Transforming Data from Dictionary to Customized Model Instance
 *
 *  @param dict The Dictionary that contains data.
 *
 *  @return Customized Model Instance
 */
+ (instancetype)JY_modelFromDictionary:(NSDictionary *)dict;


/**
 *  Transforming Data from JSON String to Customized Model Instance
 *
 *  @param jsonString
 *
 *  @return Customized Model Instance
 */
+ (instancetype)JY_modelFromJSON:(NSString *)jsonString;


/**
 *  Transforming Data from JSON String to Dictionary
 *
 *  @param jsonString
 *
 *  @return Dictionary that contains data
 */
+ (NSDictionary *)JY_dictionaryFromJSON:(NSString *)jsonString;


@end
