
//  YYBuysModel.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/11.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YYRestrictions;

@interface YYBuysModel : NSObject<NSCoding>
/**
 *  团购单ID
 */
@property (nonatomic,copy) NSString * deal_id;
/**
 *  团购标题
 */
@property (nonatomic,copy) NSString * title;
/**
 *  商品描述
 */
@property (nonatomic,copy) NSString * desc;
/**
 *  团购商品原价格
 */
@property (nonatomic,copy) NSString * list_price;
/**
 *  商品现在价格
 */
@property (nonatomic,copy) NSString * current_price;
/**
 *  已购买人数
 */
@property (nonatomic,copy) NSString * purchase_count;
/** 团购图片链接，最大图片尺寸450×280 */
@property (copy, nonatomic) NSString *image_url;

/** 团购发布上线日期 */
@property (copy, nonatomic) NSString *publish_date;

/** 团购单的截止购买日期 */
@property (copy, nonatomic) NSString *purchase_deadline;

/** 团购Web页面链接，适用于网页应用 */
@property (copy, nonatomic) NSString *deal_url;

/** 团购HTML5页面链接，适用于移动应用和联网车载应用 */
@property (copy, nonatomic) NSString *deal_h5_url;
/**
 *  用于接收是否支持随时退
 */
@property (nonatomic, assign) BOOL is_refundable;
/**
 *  这个cell 的蒙版是都要显示
 */
@property (nonatomic,assign,getter=isEditing) BOOL editing;
/**
 *  这个cell 是否被选中
 */
@property (nonatomic,assign,getter=isChceked) BOOL checked;

@end
