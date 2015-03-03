//
//  YYCollectionViewCell.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/11.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBuysModel.h"


@interface YYCollectionViewCell : UICollectionViewCell

/**
 *  接收模型数据，然后将数据赋值给每个控件的值
 */
@property (nonatomic,strong) YYBuysModel *model;

@end
