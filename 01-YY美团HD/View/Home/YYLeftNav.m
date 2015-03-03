//
//  YYLeftNav.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/5.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYLeftNav.h"

@interface YYLeftNav ()

/**
 *  大标题
 */
@property (weak, nonatomic) IBOutlet UILabel *bigTitle;
/**
 *  小标题
 */
@property (weak, nonatomic) IBOutlet UILabel *smallTitle;
/**
 *  图标
 */
@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@end

@implementation YYLeftNav

#pragma mark - 设置左边导航的自定义的item的内容
- (void)setbigText:(NSString *)bigText
{
    self.bigTitle.text = bigText;
}

- (void)setbigText:(NSString *)bigText smallText:(NSString *)smallText
{
    self.bigTitle.text = bigText;
    self.smallTitle.text = smallText;
}

- (void)setNormalIcon:(NSString *)normalIcon highIcon:(NSString *)highIcon
{
    [self.iconButton setImage:[UIImage imageNamed:normalIcon] forState:UIControlStateNormal];
    [self.iconButton setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
}
#pragma mark - 类方法，返回item

+ (instancetype)item
{
    return [[[NSBundle mainBundle]loadNibNamed:@"YYLeftNav" owner:nil options:nil ]firstObject];
}

#pragma mark - 传递监听对象及方法给这个按钮
- (void)addTarget:(id)target action:(SEL)action
{
    [self.iconButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end
