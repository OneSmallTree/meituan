//
//  NSDictionary+chinese.m
//  YYBuyTickets
//
//  Created by 阳颜 on 15/1/30.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "NSDictionary+chinese.h"

@implementation NSDictionary (chinese)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithString:@"[\n"];

//    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [str appendFormat:@"\t%@,\n",obj];
//    }];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@:%@,\n",key,obj];
    }];


    [str appendString:@"\t]\n"];
    return str;
}

@end
