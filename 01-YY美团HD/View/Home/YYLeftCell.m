//
//  YYLeftCell.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYLeftCell.h"

@implementation YYLeftCell

- (void)awakeFromNib {
    
}

+ (instancetype)cellWithTabelView:(UITableView *)tabelView
{
    static NSString *IDA = @"leftCate";
    YYLeftCell *cell = [tabelView dequeueReusableCellWithIdentifier:IDA];
    if (cell == nil)
    {
        cell = [[YYLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDA];
        cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
    }
    return cell;
}
@end
