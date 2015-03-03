//
//  YYCategoryModel.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCategoryModel : NSObject
/**
 *  分类显示的文字
 */
@property (nonatomic,copy) NSString * name;
/**
 *  显示在顶部的分类的图标
 */
@property (nonatomic,copy) NSString * icon;
/**
 *  顶部图标点击状态
 */
@property (nonatomic,copy) NSString * highlighted_icon;
/**
 *  弹窗内的图标
 */
@property (nonatomic,copy) NSString * small_icon;
/**
 *  弹窗图标的点击状态
 */
@property (nonatomic,copy) NSString * small_highlighted_icon;
/**
 *  下面的小分类数组
 */
@property (nonatomic,strong) NSArray *subcategories;
@end
