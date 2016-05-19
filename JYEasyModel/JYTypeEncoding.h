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

    JYTypeEncodingNSArray           = 1 << 16,
    JYTypeEncodingNSMutableArray    = 1 << 17,
    JYTypeEncodingNSDict            = 1 << 18,
    JYTypeEncodingNSMutableDict     = 1 << 19,
    JYTypeEncodingNSNumber          = 1 << 20,
    JYTypeEncodingNSDecimalNumber   = 1 << 21,
    JYTypeEncodingNSURL             = 1 << 22,
    JYTypeEncodingNSDate            = 1 << 23,
    JYTypeEncodingNSData            = 1 << 24,
    JYTypeEncodingNSMutableData     = 1 << 25,
    JYTypeEncodingNSString          = 1 << 26,
    JYTypeEncodingNSMutableString   = 1 << 27,
    JYTypeEncodingNSSet             = 1 << 28,
    JYTypeEncodingNSMutableSet      = 1 << 29,

    JYTypeEncodingNSValue           = 1 << 30,

    JYTypeEncodingJYModel,
    JYTypeEncodingNSUnknown
};