//
//  YYLineLabel.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/14.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//  这个是用于画线的原价格的label

#import "YYLineLabel.h"

@implementation YYLineLabel

#pragma mark -  这个方法用来划线
- (void)drawRect:(CGRect)rect {

    // 1 绘出文字，调用系统的方法
    [super drawRect:rect];

    // 2 画线也可以是画一个矩形
    CGFloat x = 0;

    // 这里y 值设置的不对啊
    CGFloat y = rect.size.height * 0.5-rect.size.height*0.1;
    CGFloat w = rect.size.width;
    CGFloat h = 1;
    UIRectFill(CGRectMake(x, y, w, h));
}
@end
