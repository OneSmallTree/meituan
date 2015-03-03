//
//  YYBuysTool.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/18.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//  处理收藏与取消收藏的工具类

#import "YYBuysTool.h"
#import "YYBuysModel.h"

#define YYCollcetFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collect_buys.data"]

#define YYHistoryFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"history_buys.data"]

static int const YYMaxHistoryBuysCount = 10;
// 用define 为什么不行呢
#define uuuuuuuu (30);
/**
 *  被收藏的团购数据,
 */
static NSMutableArray *_collcetedBuys;
static NSMutableArray *_historyBuys;
@implementation YYBuysTool

+ (void)initialize
{

    // 从文件中读取之前收藏的团购
    _collcetedBuys = [NSKeyedUnarchiver unarchiveObjectWithFile:YYCollcetFile];
    if (_collcetedBuys == nil) {
        _collcetedBuys = [NSMutableArray array];
    }

    _historyBuys = [NSKeyedUnarchiver unarchiveObjectWithFile:YYHistoryFile];
    if (_historyBuys == nil) {
        _historyBuys = [NSMutableArray array];
    }
}
/**
 *  将团购收藏到本地的方法
 *
 *  @param model 传入一个团购模型
 */
+ (void)collectBuys:(YYBuysModel *)model
{
    [_collcetedBuys insertObject:model atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collcetedBuys toFile:YYCollcetFile];
}
/**
 *  将团购从本地取消收藏的方法
 *
 *  @param model 传入一个团购模型
 */
+ (void)cancelCollectBuys:(YYBuysModel *)model
{
    [_collcetedBuys removeObject:model];
    [NSKeyedArchiver archiveRootObject:_collcetedBuys toFile:YYCollcetFile];
}
/**
 *  判断这个团购是否被收藏
 *
 *  @param model 传入一个团购模型
 */
+ (BOOL)isCollectedBuys:(YYBuysModel *)model
{
    return [_collcetedBuys containsObject:model];
}
+ (NSMutableArray *)Getcollects
{
    return _collcetedBuys;
}
+ (void)deleteBuysFromCollcets:(NSArray *)deleteArray
{
    [_collcetedBuys removeObjectsInArray:deleteArray];
    [NSKeyedArchiver archiveRootObject:_collcetedBuys toFile:YYCollcetFile];
}

/**
 *  返回所有的历史记录
 */
+ (NSArray *)historyBuys
{
    return _historyBuys;
}
/**
 *  删除数组单位的历史记录
 */
+ (void)removeHistoryBuys:(NSArray *)models
{
    [_historyBuys removeObjectsInArray:models];
    [NSKeyedArchiver archiveRootObject:_historyBuys toFile:YYHistoryFile];
}
/**
 *  添加一个历史记录
 *
 */
+ (void)addHistoryBuy:(YYBuysModel *)model
{
    [_historyBuys removeObject:model];
    [_historyBuys insertObject:model atIndex:0];

    // 如果超出最大收藏数，就删除最后一个历史记录
    if (_historyBuys.count > YYMaxHistoryBuysCount){
        [_historyBuys removeLastObject];
    }
    [NSKeyedArchiver archiveRootObject:_historyBuys toFile:YYHistoryFile];
}
/**
 *  删除一个历史记录
 */
+ (void)removeHistoryBuy:(YYBuysModel *)model
{
    [_historyBuys removeObject:model];
    [NSKeyedArchiver archiveRootObject:_historyBuys toFile:YYHistoryFile];
}
@end
