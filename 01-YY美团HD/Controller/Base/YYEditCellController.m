//
//  YYCollectController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/20.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYEditCellController.h"

static NSString *const YYEdit = @"编辑";
static NSString *const YYDone = @"完成";
#define YYNavLeftText(text) [NSString stringWithFormat:@"  %@  ",text]


@interface YYEditCellController ()

@property (nonatomic,strong) UIBarButtonItem *backItem;
@property (nonatomic,strong) UIBarButtonItem *selectAllItem;
@property (nonatomic,strong) UIBarButtonItem *unselectAllItem;
@property (nonatomic,strong) UIBarButtonItem *deleteItem;

@end

@implementation YYEditCellController

#pragma mark - 对左边的导航栏上的按钮进行懒加载
- (UIBarButtonItem *)backItem
{

    if (_backItem == nil) {
        _backItem = [UIBarButtonItem itemWithImage:@"icon_back" highImg:@"icon_back_highlighted" target:self action:@selector(back)];
    }
    return _backItem;
}
- (UIBarButtonItem *)selectAllItem
{
    if (_selectAllItem == nil) {
        _selectAllItem = [[UIBarButtonItem alloc]initWithTitle:@"全选" style:UIBarButtonItemStyleDone target:self action:@selector(selectAll)];
    }
    return _selectAllItem;
}
- (UIBarButtonItem *)unselectAllItem
{
    if (_unselectAllItem == nil) {
        _unselectAllItem = [[UIBarButtonItem alloc]initWithTitle:@"全不选" style:UIBarButtonItemStyleDone target:self action:@selector(unselectAll)];
    }
    return _unselectAllItem;
}
- (UIBarButtonItem *)deleteItem
{
    if (_deleteItem == nil) {
        _deleteItem = [[UIBarButtonItem alloc]initWithTitle:@"  删除  " style:UIBarButtonItemStyleDone target:self action:@selector(delete)];
    }
    return _deleteItem;
}
static NSString * const reuseID = @"group_cell";
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];

    //  监听通知
    [YYNoteCenter addObserver:self selector:@selector(coverClicked) name:YYCellDidCheckedNotification object:nil];

    [self coverClicked];
}
#pragma mark - 左边导航栏上的按钮被点击后触发的方法
- (void)delete
{
    NSArray *deleteArray = [self.groupBuys filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"checked == YES"]];

    // 更新归档数据
    [self deleteLocalBuys:deleteArray];

    // 更新界面数据
    [self.groupBuys removeObjectsInArray:deleteArray];
    [self.collectionView reloadData];
    // 更新按钮状态
    self.deleteItem.enabled = self.groupBuys.count;
    self.unselectAllItem.enabled = self.groupBuys.count;
    self.selectAllItem.enabled = self.groupBuys.count;


    // 更新删除按钮
    [self coverClicked];

}
- (void)unselectAll
{
    for (YYBuysModel *model in self.groupBuys) {
        model.checked = NO;
    }
    [self.collectionView reloadData];
    [self coverClicked];

}
- (void)selectAll
{
    for (YYBuysModel *model  in self.groupBuys) {
        model.checked = YES;
    }
    [self.collectionView reloadData];
    [self coverClicked];
}
#pragma mark - 收到通知后执行的方法
- (void)coverClicked
{
    // 根据筛选条件来得到数组中符合条件的模型的个数
    NSUInteger count = [self.groupBuys filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"checked == YES"]].count;
    if (count) {
        NSString *title = [NSString stringWithFormat:@"  删除(%zd)",count];
        self.deleteItem.title = YYNavLeftText(title);
        self.deleteItem.enabled = YES;
    }else{
        self.deleteItem.title = YYNavLeftText(@"  删除  ");
        self.deleteItem.enabled = NO;
    }
}
#pragma mark - 当界面快出现的时候
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.groupBuys removeAllObjects];
    [self.groupBuys addObjectsFromArray:[self GetBuysArray]];
    [self.collectionView reloadData];

    self.navigationItem.rightBarButtonItem.enabled = self.groupBuys.count;
}

#pragma mark - 设置导航栏
- (void)setupNav
{

    self.navigationItem.leftBarButtonItems = @[self.backItem];

    self.title = [self navTitle];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit)];
}
#pragma mark - 导航栏上的按钮被点击后的响应方法
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)edit
{
    NSString *title = self.navigationItem.rightBarButtonItem.title;
    if ([title isEqualToString:YYEdit]) {

        self.navigationItem.rightBarButtonItem.title = YYDone;
        // 1 进入编辑模式
        self.navigationItem.leftBarButtonItems = @[self.backItem,self.selectAllItem,self.unselectAllItem,self.deleteItem];

        // 2 将收藏数组中的所有模型的状态值editing改为yes
        for (YYBuysModel *model in self.groupBuys) {
            model.editing = YES;
        }
        [self.collectionView reloadData];
    }else{
        // 结束编辑模式
        self.navigationItem.rightBarButtonItem.title = YYEdit;
        self.navigationItem.leftBarButtonItems = @[self.backItem];
        for (YYBuysModel *model  in self.groupBuys) {
            model.editing = NO;
            model.checked = NO;
        }
        [self.collectionView reloadData];
    }
}

#pragma mark - 当控制器被销毁时，取消监听
- (void)dealloc
{
    [YYNoteCenter removeObserver:self];
}
@end

