//
//  YYDataTool.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//  专门处理数据的类

#import "YYDataTool.h"
#import "YYSortModel.h"
#import "YYCategoryModel.h"
#import "YYCityGroupModel.h"
#import "YYCityModel.h"
#import <MJExtension.h>

@implementation YYDataTool

static NSArray *_sortsArray;
+ (NSArray *)sort
{
    if (_sortsArray ==nil) {
        // 1 将字典数组转成模型数组
        _sortsArray = [YYSortModel objectArrayWithFilename:@"sorts.plist"];
    }
    return _sortsArray;
}
static NSArray *_cateGory;
+ (NSArray *)cateGory
{
    if (_cateGory == nil) {
        _cateGory = [YYCategoryModel objectArrayWithFilename:@"categories.plist"];
    }
    return _cateGory;
}

static NSArray *_cityGroup;
+ (NSArray *)cityGroup
{
    if (_cityGroup == nil) {
        _cityGroup =[YYCityGroupModel objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroup;
}

static NSArray *_city;
+ (NSArray *)city
{
    if (_city == nil) {
        _city = [YYCityModel objectArrayWithFilename:@"cities.plist"];
    }
    return _city;
}

#pragma mark - 根据城市名字得到城市模型
+ (YYCityModel *)cityWithCityName:(NSString *)cityName
{
    YYCityModel *model = nil;

    // 1 先得到cityplist文件得到的模型数组
    NSArray *tempArray = [self city];

    // 2 遍历整个数组，找到name属性进行比较
    for (YYCityModel *tempModel in tempArray) {
        if ([tempModel.name isEqualToString:cityName]) {
            return tempModel;
        }
    }
    // 3 没找到就返回空
    return model;
}

#pragma mark - 根据排序名的到排序模型
+ (YYSortModel *)sortModelWithName:(NSString *)label
{
    // 1 先得到所有排序模型
    NSArray *tempArray = [self sort];
    YYSortModel *model = nil;
    for (YYSortModel *tempModel in tempArray) {
        if ([tempModel.label  isEqualToString:label]) {
            return tempModel;
        }
    }
    // 没有找到就返回空
    return model;
}

@end
