//
//  YYBaseController.h
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/21.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+YYTwoImageBarItem.h"
#import "YYLeftNav.h"
#import "YYCollectionViewCell.h"
#import "YYDataTool.h"
#import <MJExtension.h>
#import <UIView+AutoLayout.h>
#import "MBProgressHUD+MJ.h"
#import "YYDetailController.h"
#import "YYBuysTool.h"

@interface YYBaseController : UICollectionViewController
/**
 *  显示的所有的团购
 */
@property (nonatomic,strong) NSMutableArray *groupBuys;

- (NSString *)noDataImg;
@end
