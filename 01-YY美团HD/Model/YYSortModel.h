//
//  YYSortModel.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSortModel : NSObject
/**
 *  排序显示的文字
 */
@property (nonatomic,copy) NSString *label;
/**
 *  每中排序所代表的数字
 */
@property (nonatomic,copy) NSNumber *value;
@end
