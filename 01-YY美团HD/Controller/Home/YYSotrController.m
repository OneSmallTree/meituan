//
//  YYSotrController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYSotrController.h"
#import "YYDataTool.h"
#import "YYSortModel.h"
#import "UIView+YYFrame.h"
@interface YYSotrController ()

@end

@implementation YYSotrController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 记录最后一个按钮，然后利用最后一个按钮得出控制器的大小
    UIButton *lastButton = nil;

    NSArray *modelArray = [YYDataTool sort];
    NSUInteger count = modelArray.count;
    CGFloat margin = 10;
    // 根据模型个数，利用循环创建按钮,显示排序选项
    for (int i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc]init];

        YYSortModel *sort = modelArray[i];

        // 设置按钮的文字和背景
        [button setTitle:sort.label forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal_selected"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [button addTarget:self action:@selector(postNotifiction:) forControlEvents:UIControlEventTouchUpInside];
        // 设置frame
        lastButton = button;
        button.width = 100;
        button.height = 30;
        button.x = 10;
        button.y = margin +(margin+button.height)*i;

        // 将button添加到控制器的view中
        [self.view addSubview:button];
    }
    // 设置控制器的view在pop里面的大小
    CGFloat w = lastButton.x + CGRectGetMaxX(lastButton.frame);
    CGFloat h = CGRectGetMaxY(lastButton.frame)+margin;
    self.preferredContentSize = CGSizeMake(w, h);
}
#pragma mark - 发出通知方法
- (void)postNotifiction:(UIButton *)sort
{
    // 这里发送的是点击的button上显示的文字
    // 可以根据显示显示的文字，得到它的模型
    // 根据button得到当前button的文字，然后得到这个sort模型
    YYSortModel *model = [YYDataTool sortModelWithName:[sort titleForState:UIControlStateNormal]];

    NSDictionary *infoDict = @{YYSortDidChangeKey:model};

    [YYNoteCenter postNotificationName:YYSortDidChangeNotification object:nil userInfo:infoDict];

    // 3 使弹窗消失
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
