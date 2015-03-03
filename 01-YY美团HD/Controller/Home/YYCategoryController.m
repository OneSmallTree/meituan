//
//  YYCategoryController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//  一个控制器管两个tableView
/*
 错误记录：
 1 返回右边的每组的行数时这样写
 return [self.modelArray[section] subcategories].count;
 这样每次返回的都是0行,因为每次的section都是0行开始，要根据左边点击的行数来加载右边的行数，不知道section为什么每次都是0行
 
 */
#import "YYCategoryController.h"
#import "YYCategoryModel.h"
#import "YYDataTool.h"
#import "YYLeftCell.h"
#import "YYRightCell.h"

@interface YYCategoryController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;
/**
 *  保存数据的数组
 */
@property (nonatomic,strong) NSArray *modelArray;
@end

@implementation YYCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *modelArray  = [YYDataTool cateGory];
    self.modelArray = modelArray;

    // 取消分割线
    self.leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置view的大小
    CGFloat height = 44;
    self.leftTable.rowHeight = height;
    self.rightTable.rowHeight = height;
    self.preferredContentSize = CGSizeMake(400, self.modelArray.count*height);

}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    if (tableView == self.leftTable) {
        return self.modelArray.count;
    }else{
//        NSLog(@"返回的行数是：%i",[self.modelArray[section] subcategories].count);
        NSInteger index = [self.leftTable indexPathForSelectedRow].row;
        YYCategoryModel *model = self.modelArray[index];
        return model.subcategories.count;

    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

     UITableViewCell *cell = nil;
    // 判断是左边的tableView还是右边的tableView
    if (tableView == self.leftTable)
    {
        YYCategoryModel *cate = self.modelArray[indexPath.row];
        cell = [YYLeftCell cellWithTabelView:tableView];
        cell.imageView.image = [UIImage imageNamed:cate.small_icon];
        cell.textLabel.text = cate.name;

        // 判断是否有箭头
        if (cate.subcategories.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        cell = [YYRightCell cellWithTabelView:tableView];
        NSInteger index = [self.leftTable indexPathForSelectedRow].row;
        cell.textLabel.text = [self.modelArray[index] subcategories][indexPath.row];
        }
    return cell;
}

#pragma mark - tableView的监听代理方法，这里用来同步导航栏
// 怎么将内容同步到导航栏上面呢？
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == self.leftTable) {
        [self.rightTable reloadData];

        YYCategoryModel *model = self.modelArray[indexPath.row];

        // 如果没有小分类，那么将内容弄到导航栏上，怎么弄到导航栏上呢？
        if (![model subcategories].count) {
                    // 确定没有小分类，那么当点击左边的的时候，就将内容传到导航栏上面
            [self postNotification:model indexPath:nil];
        }
    }else{
        // 得到当前左边大分类被点击的行数
        NSInteger selectedRow = [self.leftTable indexPathForSelectedRow].row;
        YYCategoryModel *model = self.modelArray[selectedRow];
        [self postNotification:model indexPath:indexPath];

    }
}

#pragma mark - 发出通知办法
- (void)postNotification:(YYCategoryModel *)model indexPath:(NSIndexPath *)indexPath
{

    // 1 使弹窗消失
    [self dismissViewControllerAnimated:YES completion:nil];
    // 2 将模型中的数据包装成发送的字典
    NSDictionary *infoDict = nil;
    if (indexPath) {
        infoDict = @{YYCateGoryDidChangeKey:model,YYSubcategoriesKey:indexPath};
    }else{
        infoDict = @{YYCateGoryDidChangeKey:model,YYSubcategoriesKey:@"全部"};
    }
    // 3 发出通知
    [YYNoteCenter postNotificationName:YYCateGoryDidChangeNotification object:nil userInfo:infoDict];
}
@end
