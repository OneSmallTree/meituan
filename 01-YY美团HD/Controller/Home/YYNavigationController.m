//
//  YYNavigationController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//  自定义导航栏控制器

#import "YYNavigationController.h"

@interface YYNavigationController ()

@end

@implementation YYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏上面item的文字属性
    UIBarButtonItem *item = [UIBarButtonItem appearance];

    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = YYColor(21, 188, 173);
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];

    NSMutableDictionary *disattrs = [NSMutableDictionary dictionary];
    disattrs[NSForegroundColorAttributeName] = YYColor(100, 100, 100);
    [item setTitleTextAttributes:disattrs forState:UIControlStateDisabled];

  }

@end
