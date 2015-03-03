//
//  UIBarButtonItem+YYTwoImageBarItem.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/4.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "UIBarButtonItem+YYTwoImageBarItem.h"

@implementation UIBarButtonItem (YYTwoImageBarItem)

+ (instancetype)itemWithImage:(NSString *)image highImg:(NSString *)highImg target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImg] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

//    [button setBackgroundColor:[UIColor redColor]];
    // 设置按钮的尺寸
    button.frame = (CGRect){CGPointZero,button.currentImage.size};
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    return item;

}
@end
