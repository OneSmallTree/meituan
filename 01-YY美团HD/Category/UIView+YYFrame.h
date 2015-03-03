//
//  UIView+YYFrame.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/4.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YYFrame)
/**
 *  宽度
 */
@property (nonatomic,assign) CGFloat width;
/**
 *  高度
 */
@property (nonatomic,assign) CGFloat height;
/**
 *  原点x的值
 */
@property (nonatomic,assign) CGFloat x;
/**
 *  原点y的值
 */
@property (nonatomic,assign) CGFloat y;
/**
 *  原点
 */
@property (nonatomic,assign) CGPoint origin;
/**
 *  大小
 */
@property (nonatomic,assign) CGSize size;
/**
 *  中心点
 */
@property (nonatomic,assign) CGPoint center;

@end
