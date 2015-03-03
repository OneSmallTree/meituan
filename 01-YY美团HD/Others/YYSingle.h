//
//  YYSingle.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/11.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#define YYSingle_H + (instancetype)sharedInstance

#define YYSingle_M \
static id _instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (instancetype)sharedInstance \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc]init]; \
    }); \
    return _instance; \
} \

