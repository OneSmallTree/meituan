//
//  YYSmallCityModel.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/8.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSmallCityModel : NSObject

/**
 *  区名
 */
@property (nonatomic,copy) NSString * name;
/**
 *  县名，及全部
 */
@property (nonatomic,strong) NSArray *subdistricts;
@end
