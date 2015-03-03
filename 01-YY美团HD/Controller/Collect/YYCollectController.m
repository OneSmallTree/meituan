//
//  YYCollectController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/20.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYCollectController.h"

@interface YYCollectController ()

@end

@implementation YYCollectController

static NSString * const reuseID = @"group_cell";
- (void)viewDidLoad {
    [super viewDidLoad];

   }

- (NSString *)noDataImg
{
    return @"icon_collects_empty";
}
- (NSString *)navTitle
{
    return @"我的收藏";
}
- (void)deleteLocalBuys:(NSMutableArray *)deleteArrays
{
    [YYBuysTool deleteBuysFromCollcets:deleteArrays];
}
- (NSArray *)GetBuysArray
{
    return [YYBuysTool Getcollects];
}
@end

