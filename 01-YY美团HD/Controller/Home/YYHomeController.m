//
//  YYHomeController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/4.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYHomeController.h"
#import "UIBarButtonItem+YYTwoImageBarItem.h"
#import "UIView+YYFrame.h"
#import "YYSotrController.h"
#import "YYLocateController.h"
#import "YYCategoryController.h"
#import "YYCategoryModel.h"
#import "YYCityModel.h"
#import "YYCollectionViewCell.h"
#import "YYSortModel.h"
#import "DPAPI.h"
#import "YYFindBuysResulet.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "AwesomeMenu.h"
#import "YYCollectController.h"
#import "YYNavigationController.h"
#import "YYHistoryController.h"
#import "YYSearchController.h"


@interface YYHomeController ()<AwesomeMenuDelegate>
/**
 *  排序按钮
 */
@property (nonatomic,strong) UIBarButtonItem *sortedItem;
/**
 *  地区按钮
 */
@property (nonatomic,strong) UIBarButtonItem *locationItem;
/**
 *  分类按钮
 */
@property (nonatomic,strong) UIBarButtonItem *categoryItem;
/**
 *  记录一下当前城市，好加载当前这个城市的区和县
 */
@property (nonatomic,strong) YYCityModel *currentCity;
/**
 *  显示的所有的团购
 */
@property (nonatomic,strong) NSMutableArray *groupBuys;
/**
 *  当前选择的地区，发送给服务器的值
 */
@property (nonatomic,strong) NSString *currentRegion;
/**
 *  当前选择的分类，发送给服务器
 */
@property (nonatomic,strong) NSString *currentCategory;
/**
 *  当前现选择的排序模型，发送给服务器相应的value
 */
@property (nonatomic,strong) YYSortModel *currentSort;

/**
 *  当前正在发送的网络请求,将网络请求保存下来，才能取消之前的网络请求
 */
@property (nonatomic,strong) DPRequest *currentRequest;
/**
 *  记录当前页面
 */
@property (nonatomic,assign) int currentPage;
/**
 *  没有数据的时候显示的图片
 */
@property (nonatomic,strong) UIImageView *noDataImage;
@property (nonatomic,strong) YYFindBuysResulet *result;
/**
 *  保存浏览过的团购
 */
@property (nonatomic,strong) NSMutableArray *historyArray;
@end

@implementation YYHomeController
#pragma matrk - 对保存浏览记录的数组进行初始化
- (NSMutableArray *)historyArray
{
    if (_historyArray == nil) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}
#pragma park - 环形菜单的初始化
- (void)setupAwesomeMenu
{
    UIImage *itemBg = [UIImage imageNamed:@"bg_pathMenu_black_normal"];

    // 创建菜单item(按钮)
    AwesomeMenuItem *personalItem = [[AwesomeMenuItem alloc]initWithImage:itemBg highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_mine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mine_highlighted"]];

    AwesomeMenuItem *collectItem = [[AwesomeMenuItem alloc]initWithImage:itemBg highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];

    AwesomeMenuItem *historyItem = [[AwesomeMenuItem alloc]initWithImage:itemBg highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_highlighted"]];

    AwesomeMenuItem *moreItem = [[AwesomeMenuItem alloc]initWithImage:itemBg highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_more_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_more_highlighted"]];

    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc]initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mine_highlighted"]];
    // 创建菜单
    NSArray *items = @[personalItem,collectItem,historyItem,moreItem];
    AwesomeMenu *menu = [[AwesomeMenu alloc]initWithFrame:CGRectZero startItem:startItem optionMenus:items];
    menu.delegate = self;
    menu.alpha = 1;
    [self.view addSubview:menu];

    // 设置菜单约束
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    CGFloat menuWH = 250;
    [menu autoSetDimensionsToSize:CGSizeMake(menuWH, menuWH)];

    // 设置菜单信息
    CGFloat margin = 50;
    menu.menuWholeAngle = M_PI_2;
    menu.startPoint = CGPointMake(margin, menuWH -margin);
    menu.rotateAddButton = NO;
}
#pragma mark - 对环形菜单进行监听- AwesomeMenuDelegate
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    switch (idx) {
        case 0:// 个人
            break;
        case 1: // 收藏
        {   YYCollectController *collecetVC = [[YYCollectController alloc]initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];

            YYNavigationController *nav = [[YYNavigationController alloc]initWithRootViewController:collecetVC];

            [self presentViewController:nav animated:YES completion:nil];

        }
            break;
        case 2: // 历史
        {
            YYHistoryController *historyVC = [[YYHistoryController alloc]initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init] ];

            // 将保存的团购数据传过去
            YYNavigationController *nav = [[YYNavigationController alloc]initWithRootViewController:historyVC];

            [self presentViewController:nav animated:YES completion:nil];

        }
            break;
        case 3: // 更多
            break;
    }
    [self awesomeMenuWillAnimateClose:menu];
}

// 即将展开的时候调用的方法
- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
    menu.alpha = 1;
}
// 展开结束的时候调用的方法
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu
{

}

// 即将收缩的时候调用的方法
- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu
{
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];
    menu.alpha = 0.5;
}

// 收藏完成的时候调用的方法
- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu
{

}


- (void)viewDidLoad {
    [super viewDidLoad];

    // 1 设置导航栏左边
    [self setupLeft];

    // 2 设置导航栏右边
    [self setupRight];

    // 3 调用监听通知的方法
    [self receiveNotification];

    // 5 增加刷新功能
    [self setupRefresh];

    // 6 增加环形菜单
    [self setupAwesomeMenu];


}
#pragma mark - 增加刷新功能
- (void)setupRefresh
{
    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewGroupBuys)];
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreGroupBuys)];

    // 这一句是什么意思,这个赋值YES就不能向下拉刷新呢
//    self.collectionView.footerHidden = NO;

    // 刚开始就是加载的北京的数据
    self.currentCity = [YYDataTool cityWithCityName:@"北京"];
    [self.collectionView headerBeginRefreshing];


}
#pragma mark - 网络访问，得到数据
- (void)loadNewGroupBuys;
{
    // 1 如果当前选择的城市没有值，那么就不调用这个方法
    if (self.currentCity == nil) {
        return;
    }

    // 2 取消上次的请求
    [self.currentRequest disconnect];

    // 3 创建请求参数的字典,需要传递的参数是城市，选择的地区，选择的分类，选择的排序编号
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = self.currentCity.name;

    if (self.currentRegion) {
        params[@"region"] = self.currentRegion;
    }
    if (self.currentCategory) {
        params[@"category"] = self.currentCategory;
    }
    if (self.currentSort) {
        params[@"sort"] = self.currentSort.value;
    }
    NSLog(@"传递的参数是：%@",params);

    // 3 发送请求给服务器
    self.currentRequest = [[DPAPI sharedInstance] request:@"v1/deal/find_deals" params:params success:^(id json) {
        self.result = [YYFindBuysResulet objectWithKeyValues:json];
        [self.groupBuys removeAllObjects];
        [self.groupBuys addObjectsFromArray:self.result.deals];
        [self.collectionView reloadData];

        /**
         *  这是第一页的数据
         */
        self.currentPage = 1;
        // 应该滚动到第一行的
        [self.collectionView headerEndRefreshing];

    } failure:^(NSError *error) {
        NSLog(@"错误是：%@",error);
        [MBProgressHUD showError:@"网络繁忙，请稍后再试"];
        [self.collectionView headerEndRefreshing];
    }];
}

// 加载更多数据
- (void)loadMoreGroupBuys;
{
    // 1 如果当前选择的城市没有值，那么就不调用这个方法
    if (self.currentCity == nil) {return;}
    // 2 取消上次的请求
    [self.currentRequest disconnect];
    // 3 得到当前页数，然后对页数进行+1操作，再将页数经过处理发送给服务器
    int tempPage = self.currentPage;
    tempPage++;

    // 4 创建请求参数的字典,需要传递的参数是城市，选择的地区，选择的分类，选择的排序编号
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = self.currentCity.name;
    params[@"page"] = @(tempPage);
    if (self.currentRegion) {
        params[@"region"] = self.currentRegion;
    }
    if (self.currentCategory) {
        params[@"category"] = self.currentCategory;
    }
    if (self.currentSort) {
        params[@"sort"] = self.currentSort.value;
    }
    NSLog(@"传递的参数是：%@",params);

    // 3 发送请求给服务器
    self.currentRequest = [[DPAPI sharedInstance] request:@"v1/deal/find_deals" params:params success:^(id json) {

        self.result = [YYFindBuysResulet objectWithKeyValues:json];

        // 不能移除之前的数据，应该在之前的数据后面添加数据
        [self.groupBuys addObjectsFromArray:self.result.deals];
        [self.collectionView reloadData];

        /**
         *  这是第一页的数据
         */
        self.currentPage = tempPage;
        [self.collectionView footerEndRefreshing];

    } failure:^(NSError *error) {
        NSLog(@"错误是：%@",error);
        [MBProgressHUD showError:@"网络繁忙，请稍后再试"];
        [self.collectionView footerEndRefreshing];
    }];
}

#pragma mark - 设置导航栏
- (void)setupLeft
{
    // 1 logo
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];

    // 2 分类
    YYLeftNav *cateItem = [YYLeftNav item];
    [cateItem setbigText:@"分类" smallText:@"全部"];
    [cateItem setNormalIcon:@"icon_category_-1" highIcon:@"icon_category_highlighted_-1"];
    [cateItem addTarget:self action:@selector(categoryClick)];
    self.categoryItem = [[UIBarButtonItem alloc]initWithCustomView:cateItem];

    // 3 地区
    YYLeftNav *locateItem = [YYLeftNav item];
    [locateItem setbigText:@"北京-全部" smallText:@""];
    [locateItem setNormalIcon:@"icon_district" highIcon:@"icon_district_highlighted"];
    [locateItem addTarget:self action:@selector(locationClick)];
    self.locationItem = [[UIBarButtonItem alloc]initWithCustomView:locateItem];

    // 4 排序
    YYLeftNav *sortItem = [YYLeftNav item];
    [sortItem setbigText:@"排序" smallText:@"价格"];
    [sortItem setNormalIcon:@"icon_sort" highIcon:@"icon_sort_highlighted"];
    [sortItem addTarget:self action:@selector(sortedClick)];
    self.sortedItem = [[UIBarButtonItem alloc]initWithCustomView:sortItem];
    self.navigationItem.leftBarButtonItems = @[logoItem,self.categoryItem,self.locationItem,self.sortedItem];
    

}
// 设置导航栏右边的内容，有搜索框，和定位
- (void)setupRight
{
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithImage:@"icon_search" highImg:@"icon_search_highlighted" target:self action:@selector(searchClick)];

    searchItem.customView.width = 50;

     UIBarButtonItem *mapItem = [UIBarButtonItem itemWithImage:@"icon_map" highImg:@"icon_map_highlighted" target:self action:@selector(mapClick)];
    mapItem.customView.width = 50;

    self.navigationItem.rightBarButtonItems = @[searchItem,mapItem];

}

#pragma mark - 导航栏右边按钮点击后的响应方法
- (void)searchClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    YYSearchController *vc = [[YYSearchController alloc]initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];

    YYNavigationController *nav = [[YYNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)mapClick
{
     NSLog(@"地图被点击了");

}
// 如果监听方法带参数，传过来的则是按钮，点击按钮后，传过来的参数就是按钮本身
- (void)categoryClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    YYCategoryController *categoryVC = [[YYCategoryController alloc]init];
    categoryVC.modalPresentationStyle = UIModalPresentationPopover;
    categoryVC.popoverPresentationController.barButtonItem = self.categoryItem;
    [self presentViewController:categoryVC animated:YES completion:nil];

}
- (void)locationClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    YYLocateController *locateVC = [[YYLocateController alloc]init];
    locateVC.modalPresentationStyle = UIModalPresentationPopover;
    locateVC.popoverPresentationController.barButtonItem = self.locationItem;
    
    locateVC.districts = self.currentCity.districts;
    [self presentViewController:locateVC animated:YES completion:nil];
}
- (void)sortedClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    YYSotrController *sortVC = [[YYSotrController alloc]init];
    sortVC.modalPresentationStyle = UIModalPresentationPopover;
    sortVC.popoverPresentationController.barButtonItem = self.sortedItem;
    [self presentViewController:sortVC animated:YES completion:nil];
}
#pragma mark - 接收通知
- (void)receiveNotification
{
    // 1 监听通知
    [YYNoteCenter addObserver:self selector:@selector(categoryChange:) name:YYCateGoryDidChangeNotification object:nil];
    [YYNoteCenter addObserver:self selector:@selector(sortChange:) name:YYSortDidChangeNotification object:nil];
    [YYNoteCenter addObserver:self selector:@selector(cityChange:) name:YYCityDidChangeNotification object:nil];
    [YYNoteCenter addObserver:self selector:@selector(smallCityChange:) name:YYSmallCityDidChangeNotification object:nil];
}


#pragma mark - 接收到通知后，执行的方法，对导航栏的内容进行更改

- (void)smallCityChange:(NSNotification *)note
{
    // 1 取出传递过来的内容
    NSString *title = note.userInfo[YYSmallCityNameDidChangeKey];
    NSString *smallTitle = note.userInfo[YYSmallCitySmallNameDidChangeKey];
     YYLeftNav *smallCity = (YYLeftNav *)self.locationItem.customView;
    if (title) {
        NSString *bigTitle = [NSString stringWithFormat:@"%@-%@",self.currentCity.name,title];
        [smallCity setbigText:bigTitle smallText:smallTitle];
    }else{
        // 这个是右边表格没有内容所发出的通知
        NSString *bigTitle = self.currentCity.name;
        [smallCity setbigText:bigTitle smallText:smallTitle];
        if ([smallTitle isEqualToString:@"全部"]) {
            smallTitle = nil;
        }
    }

    // 2 记录选择的城市的区县
    self.currentRegion = smallTitle;
    [self loadNewGroupBuys];
}
- (void)cityChange:(NSNotification *)note
{
    YYLeftNav *cityItem = (YYLeftNav *)self.locationItem.customView;
    YYCityModel *cityModel = note.userInfo[YYCityDidChangeKey];
    NSString *tempString = [NSString stringWithFormat:@"%@-全部",cityModel.name];
    [cityItem setbigText:tempString smallText:@""];
    self.currentCity = cityModel;
    // 每次换一个城市，区县内容就要清空
    self.currentRegion = nil;
    [self loadNewGroupBuys];

}
- (void)sortChange:(NSNotification *)note
{
    YYLeftNav *sortItem = (YYLeftNav *)self.sortedItem.customView;
    YYSortModel *sortModel = note.userInfo[YYSortDidChangeKey];

    // 这里应该传递模型，因为要得到这个排序的结果的value
    self.currentSort = sortModel;

    NSString *text = sortModel.label;
    [sortItem setbigText:@"排序" smallText:text];
    [self loadNewGroupBuys];

}
- (void)categoryChange:(NSNotification *)note
{
    // 1 取出模型
    YYCategoryModel *cate = note.userInfo[YYCateGoryDidChangeKey];
    // 2 得到customView
    YYLeftNav *cateItem = (YYLeftNav *)self.categoryItem.customView;


    if (![note.userInfo[YYSubcategoriesKey] isEqual: @"全部" ]) {
        NSInteger row = [note.userInfo[YYSubcategoriesKey]row ];
         NSString *smallText = cate.subcategories[row];
        [cateItem setbigText:cate.name smallText:smallText];

        // 判断传递的值，如果在第二次选择的时候选择全部，则保存大分类
        if ([smallText isEqualToString: @"全部"]) {
            self.currentCategory = cate.name;
        }else{
            self.currentCategory = smallText;
        }

    }else{
        [cateItem setbigText:cate.name smallText:@"全部"];
        if ([cate.name isEqualToString:@"全部分类"])
        {
            self.currentCategory = nil;
        }else{

            self.currentCategory = cate.name;
        }

    }
    [self loadNewGroupBuys];
}

#pragma mark - 当控制器被销毁时，取消监听
- (void)dealloc
{
    [YYNoteCenter removeObserver:self];
    [self.currentRequest disconnect];
}
@end
