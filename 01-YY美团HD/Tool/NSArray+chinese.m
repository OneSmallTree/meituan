//
//  NSArray+chinese.m
//  02-log
//
//  Created by 阳颜 on 15/1/16.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "NSArray+chinese.h"

@implementation NSArray (chinese)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithString:@"(\n"];

    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"\t%@,\n",obj];
    }];

    [str appendString:@")\n"];
    return str;
}
@end
