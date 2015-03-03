//
//  UIView+YYFrame.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/4.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "UIView+YYFrame.h"

@implementation UIView (YYFrame)

- (void)setX:(CGFloat)x
{
    CGRect temp = self.frame;
    temp.origin.x = x;
    self.frame = temp;
}

- (void)setY:(CGFloat)y
{
    CGRect temp = self.frame;
    temp.origin.y = y;
    self.frame = temp;
}
//- (void)setCenter:(CGPoint)center
//{
//    CGPoint temp = self.center;
//    temp = center;
//    // 这句话不是自己调自己了了吗？，给center设值
//    self.center = temp;
//}

- (void)setOrigin:(CGPoint)origin
{
    CGRect temp = self.frame;
    temp.origin = origin;
    self.frame = temp;
}
-(void)setWidth:(CGFloat)width
{
    CGRect temp = self.frame;
    temp.size.width = width;
    self.frame = temp;
}
- (void)setHeight:(CGFloat)height
{
    CGRect temp = self.frame;
    temp.size.height = height;
    self.frame = temp;
}
- (void)setSize:(CGSize)size
{
    CGRect temp = self.frame;
    temp.size = size;
    self.frame = temp;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (CGSize)size
{
    return self.frame.size;
}
- (CGPoint)origin
{
    return self.frame.origin;
}
//- (CGPoint)center
//{
//    // 这句话是得到center的值，也是自己调用自己
//    return self.center;
//}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
@end
