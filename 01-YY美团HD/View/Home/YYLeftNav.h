//
//  YYLeftNav.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/5.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYLeftNav :UIView

- (void)setbigText:(NSString *)bigText;

- (void)setbigText:(NSString *)bigText smallText:(NSString *)smallText;

- (void)setNormalIcon:(NSString *)normalIcon highIcon:(NSString *)highIcon;

+ (instancetype)item;

- (void)addTarget:(id)target action:(SEL)action;
@end
