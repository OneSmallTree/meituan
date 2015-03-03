//
//  YYCollectController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/20.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//
#import "YYHistoryController.h"

@interface YYHistoryController ()

@end

@implementation YYHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)noDataImg
{
    return @"icon_latestBrowse_empty";
}
- (NSString *)navTitle
{
    return @"历史记录";
}
- (void)deleteLocalBuys:(NSArray *)deleteArrays
{
    [YYBuysTool removeHistoryBuys:deleteArrays];

}
- (NSArray *)GetBuysArray
{
    return [YYBuysTool historyBuys];
}
@end

