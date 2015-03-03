//
//  YYEditCellController.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/21.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYBaseController.h"

@interface YYEditCellController : YYBaseController

/**
 *  得到导航栏的标题
 */
- (NSString *)navTitle;
/**
 *  删除归档中的数据
 */
- (void)deleteLocalBuys:(NSMutableArray *)deleteArrays;
/**
 *  从哪里获得模型数组
 */
- (NSArray *)GetBuysArray;
@end
