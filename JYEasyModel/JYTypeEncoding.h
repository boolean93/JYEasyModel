//
//  JYTypeEncoding.h
//  JYEasyModel
//
//  Created by BooleanMac on 16/4/17.
//  Copyright © 2016年 Boolean93. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, JYTypeEncoding) {
    JYTypeEncodingUnknown   =   0,

    JYTypeEncodingChar      =   1 << 0,
    JYTypeEncodingInt       =   1 << 1,
    JYTypeEncodingShort     =   1 << 2,
    JYTypeEncodingLong      =   1 << 3,
    JYTypeEncodingLongLong  =   1 << 4,
    JYTypeEncodingUChar     =   1 << 5,
    JYTypeEncodingUInt      =   1 << 6,
    JYTypeEncodingUShort    =   1 << 7,
    JYTypeEncodingULong     =   1 << 8,
    JYTypeEncodingULongLong =   1 << 9,
    JYTypeEncodingFloat     =   1 << 10,
    JYTypeEncodingDouble    =   1 << 11,
    JYTypeEncodingBool      =   1 << 12,
    JYTypeEncodingVoid      =   1 << 13,
    JYTypeEncodingCString   =   1 << 14,
    JYTypeEncodingSEL       =   1 << 15,

    JYTypeEncodingNSArray,
    JYTypeEncodingNSMutableArray,
    JYTypeEncodingNSDict,
    JYTypeEncodingNSMutableDict,
    JYTypeEncodingNSNumber,
    JYTypeEncodingNSDecimalNumber,
    JYTypeEncodingNSURL,
    JYTypeEncodingNSDate,
    JYTypeEncodingNSData,
    JYTypeEncodingNSMutableData,
    JYTypeEncodingNSString,
    JYTypeEncodingNSMutableString,
    JYTypeEncodingNSSet,
    JYTypeEncodingNSMutableSet,
    JYTypeEncodingNSValue,

    JYTypeEncodingNSUnknown
};
