//
//  YYCollectController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/20.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYBaseController.h"

@interface YYBaseController ()

/**
 *  没有数据的时候显示的图片
 */
@property (nonatomic,strong) UIImageView *noDataImage;

@end

@implementation YYBaseController

#pragma mark - 对左边的导航栏上的按钮进行懒加载
static NSString * const reuseID = @"group_cell";
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:@"YYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
    self.collectionView.backgroundColor = YYColor(230, 230, 230);

    // 4 刚开始的时候就要调用一下屏幕监听旋转的方法
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self viewWillTransitionToSize:screenSize withTransitionCoordinator:nil];
}

#pragma mark - 对cell的点击进行监听
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 监听到以后，modal出详情控制器
    YYBuysModel *model = self.groupBuys[indexPath.item];

    YYDetailController *detail = [[YYDetailController alloc]init];
    detail.model = model;
    [self presentViewController:detail animated:YES completion:nil];

    // 2 将该团购数据保存进数组中
    [YYBuysTool addHistoryBuy:model];
}

#pragma mark - 对没有数据的时候的图片进行懒加载
- (UIImageView *)noDataImage
{
    if (_noDataImage == nil) {
        _noDataImage = [[UIImageView alloc]init];
        _noDataImage.image = [UIImage imageNamed:[self noDataImg]];
        _noDataImage.contentMode = UIViewContentModeCenter;
        [self.view addSubview:_noDataImage];

        // 1 对这个背景图进行设定约束，用第三方框架
        [_noDataImage autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    }
    return _noDataImage;
}

#pragma mark - 对屏幕旋转进行监听,对collectionView 的layout 进行设置
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout * )self.collectionViewLayout;
    layout.itemSize = CGSizeMake(305, 305);

    CGFloat screenW = size.width;
    int cols = (screenW == YYMaxScreen)? 3:2 ;

    // 屏幕宽度减去所有内容的宽度，剩下的就是间隔的宽度，再除以有几个间隔
    CGFloat allWidth = cols * layout.itemSize.width;
    CGFloat Xmargin = (screenW - allWidth)/(cols + 1);
    CGFloat Ymargin = (cols == 3)?Xmargin:30;
    layout.sectionInset = UIEdgeInsetsMake(Ymargin, Xmargin, Ymargin, Xmargin);
    layout.minimumInteritemSpacing = Xmargin;
    layout.minimumLineSpacing = Ymargin;
}
#pragma mark - 对要显示的团购数组数据进行懒加载
- (NSMutableArray *)groupBuys
{
    if (_groupBuys == nil) {
        _groupBuys = [NSMutableArray array];
    }
    return _groupBuys;
}
#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger count = self.groupBuys.count;
    // 如果有搜索结果就不显示没有团购数据的图片
    self.noDataImage.hidden = (count>0);
    return count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    YYBuysModel *model = self.groupBuys[indexPath.item];
    cell.model = model;
    return cell;
}

@end

