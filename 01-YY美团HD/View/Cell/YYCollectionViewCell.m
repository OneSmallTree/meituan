//
//  YYCollectionViewCell.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/11.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYCollectionViewCell.h"
#import "YYLineLabel.h"
#import <UIImageView+WebCache.h>
#import "NSString+YYCorrentCurrentPrice.h"

@interface YYCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet YYLineLabel *pastPrice;
@property (weak, nonatomic) IBOutlet UILabel *buyCount;
/**
 *  与之相连的是group_cell 而不是file's owner 不知道有什么区别呢？好像后来加了图片后reuseID就没有提示了，需要自己再写一遍，是从这里开始出错的吗？
 */
@property (weak, nonatomic) IBOutlet UIImageView *mark;

@property (weak, nonatomic) IBOutlet UIImageView *clickImg;
@property (weak, nonatomic) IBOutlet UIButton *mengban;
- (IBAction)mengbanClick;

@end

@implementation YYCollectionViewCell

#pragma mark - xib 加载完后调用这个方法
- (void)awakeFromNib {

    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dealcell"]];

}


- (void)setModel:(YYBuysModel *)model
{
    _model = model;

    // important 根据模型的状态值来显示view中蒙版和选中的图片的显示或者隐藏
    self.mengban.hidden = !model.editing;
    self.clickImg.hidden = !model.checked;

    // 1 给各控件进行赋值
    // 图片要请求网络资源，用到SDWebImage
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];

    self.name.text = model.title;
    self.desc.text = model.desc;

    NSString *price = [model.current_price dealPriceString];
    self.currentPrice.text = [NSString stringWithFormat:@"￥%@",price];
    self.pastPrice.text = [NSString stringWithFormat:@"￥%@",model.list_price];
    self.buyCount.text = [NSString stringWithFormat:@"已售%@",model.purchase_count];

    // 2 对新单标记的显示

    // 2.1 设置时间格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *now = [fmt stringFromDate:[NSDate date]];

    // 2.2 对得到的时间进行比较
    NSComparisonResult result = [now compare:model.publish_date];
    /**
     *  当结果为降序的时候，也就是现在的时间比发布的时间新，那么就隐藏新单这个标记
     *
     */
    self.mark.hidden = (result == NSOrderedDescending);
}
// 当蒙版被选中的时候，这个cell 的选中图片就显示出来
- (IBAction)mengbanClick {

    // 1 改变模型中的状态值
    self.model.checked = !self.model.isChceked;
    // 2 显示或者隐藏
    self.clickImg.hidden = !self.model.isChceked;
    // 3 发出通知，当这个cell 被点击后发出通知
    [YYNoteCenter postNotificationName:YYCellDidCheckedNotification object:nil];
}

@end
