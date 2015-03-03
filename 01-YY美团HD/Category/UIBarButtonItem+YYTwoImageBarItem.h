//
//  UIBarButtonItem+YYTwoImageBarItem.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/4.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YYTwoImageBarItem)

+ (instancetype)itemWithImage:(NSString *)image highImg:(NSString *)img target:(id)target action:(SEL)action;
@end
