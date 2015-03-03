//
//  YYCityGroupModel.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCityGroupModel : NSObject
/**
 *  城市
 */
@property (nonatomic,strong) NSArray *cities;
/**
 *  城市分组的标题，首字母
 */
@property (nonatomic,copy) NSString * title;
@end
