//
//  YYCityModel.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCityModel : NSObject

 /**
 *  城市名
 */
@property (nonatomic,copy) NSString * name;
/**
 *  拼音
 */
@property (nonatomic,copy) NSString * pinYin;
/**
 *  拼音首字母
 */
@property (nonatomic,copy) NSString * pinYinHead;
/**
 *  包含的地区
 */
@property (nonatomic,strong) NSArray *districts;
@end
