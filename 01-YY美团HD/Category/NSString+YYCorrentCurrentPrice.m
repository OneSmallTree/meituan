//
//  NSString+YYCorrentCurrentPrice.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/15.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "NSString+YYCorrentCurrentPrice.h"

@implementation NSString (YYCorrentCurrentPrice)
- (instancetype)dealPriceString
{
    // 1 得到当前要处理的字符串
    NSString *price = self;
    // 2 得到小数点所在的位置
    NSUInteger locate = [price rangeOfString:@"."].location;
    // 3 遍历小数点后的位置到字符串结束，如果位数大于2位，则直接截取剩下两位
    if (price.length > 2 && (locate != NSNotFound)) {
        if ((price.length - locate) > 2 ) {
            price = [price substringToIndex:locate+3];
            return price;
        }
    }
    return price;
}
@end
