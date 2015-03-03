//
//  YYRightCell.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYRightCell.h"

@implementation YYRightCell

- (void)awakeFromNib {
    // Initialization code
}
+ (instancetype)cellWithTabelView:(UITableView *)tabelView
{
    static NSString *IDB = @"rightCate";
    YYRightCell *cell = [tabelView dequeueReusableCellWithIdentifier:IDB];
    if (cell == nil)
    {
        cell = [[YYRightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDB];
        cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
    }
    return cell;
}

@end
