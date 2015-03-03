//
//  YYBuysTool.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/18.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YYBuysModel;

@interface YYBuysTool : NSObject
/**
 *  将团购收藏到本地的方法
 *
 *  @param model 传入一个团购模型
 */
+ (void)collectBuys:(YYBuysModel *)model;
/**
 *  将团购从本地取消收藏的方法
 *
 *  @param model 传入一个团购模型
 */
+ (void)cancelCollectBuys:(YYBuysModel *)model;
/**
 *  判断这个团购是否被收藏
 *
 *  @param model 传入一个团购模型
 */
+ (BOOL)isCollectedBuys:(YYBuysModel *)model;

/**
 *  得到保存的团购的模型的数组
 *
 *  @return 返回可变数组
 */
+ (NSMutableArray *)Getcollects;
/**
 *  传入一个要删除的数组，将其从归档中删除
 *
 *  @param deleteArray 要删除的模型数组
 */
+ (void)deleteBuysFromCollcets:(NSArray *)deleteArray;
/**
 *  返回所有的历史记录
 */
+ (NSArray *)historyBuys;
/**
 *  删除数组单位的历史记录
 */
+ (void)removeHistoryBuys:(NSArray *)models;
/**
 *  添加一个历史记录
 *
 */
+ (void)addHistoryBuy:(YYBuysModel *)model;
/**
 *  删除一个历史记录
 */
+ (void)removeHistoryBuy:(YYBuysModel *)model;
@end
