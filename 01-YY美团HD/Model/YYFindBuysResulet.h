//
//  YYFindBuysResulet.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/11.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYFindBuysResulet : NSObject
/**
 *  所有团购总数
 */
@property (nonatomic,assign) int total;
/**
 *  本次团购数据，都是团购模型,这里必须写成deals和字典中的key值一样，才能用KVC
 */
@property (nonatomic,strong) NSArray *deals;

@end
