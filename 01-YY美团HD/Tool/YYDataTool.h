//
//  YYDataTool.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//  将数据转换成模型

#import <Foundation/Foundation.h>
@class YYCityModel;
@class YYSortModel;


@interface YYDataTool : NSObject
/**
 *  返回排序模型
 *
 *  @return 返回模型数组
 */
+ (NSArray *)sort;
/**
 *  返回分类数组
 *
 *  @return 返回分类模型数组
 */
+ (NSArray *)cateGory;
/**
 *  返回成熟分组
 *
 *  @return 返回城市分组模型
 */
+ (NSArray *)cityGroup;
/**
 *  返回城市模型
 *
 *  @return 城市模型，有拼音的那个
 */
+ (NSArray *)city;
/**
 *  传入城市名字，得到这个城市的cityModel
 */
+ (YYCityModel *)cityWithCityName:(NSString *)cityName;
/**
 *  根据传入的排序名字，得到这个sort模型
 *
 */
+ (YYSortModel *)sortModelWithName:(NSString *)label;

@end
