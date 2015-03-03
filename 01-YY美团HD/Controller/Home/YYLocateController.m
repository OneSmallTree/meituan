//
//  YYLocateController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

/*
 问题总结：
 
 1 
 
 
 */
#import "YYLocateController.h"
#import "YYChangecityController.h"
#import "YYNavigationController.h"
#import "YYDataTool.h"
#import "YYCityModel.h"
#import "YYSmallCityModel.h"
#import "YYLeftCell.h"
#import "YYRightCell.h"

@interface YYLocateController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  左边的tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
/**
 *  右边的tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *rightTable;


- (IBAction)changeCity;
@end

@implementation YYLocateController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.leftTable.separatorStyle = self.rightTable.separatorStyle = UITableViewCellSelectionStyleNone;

    // 设置view的大小
    self.preferredContentSize = CGSizeMake(400, 500);

}

#pragma mark - 数据源方法,这个也是分左右两个tableView的
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 当加载的是左边的控制器的时候,返回的是district的计数
    if (tableView == self.leftTable) {
        return self.districts.count;
    }else{

        // 当加载的是右边的控制器的时候，返回的当点击左边的城市下面的小城市
       // 如果不监听左边的点击的行数后，刷新右边的数据话，右边的数据是不会有数据的，因为刚开始加载的时候左边的行没有一行被点击了，所以左边的某行被点击后，需要重新刷新右边的数据，才能将数据显示出来
        NSUInteger selectedRow = [self.leftTable indexPathForSelectedRow].row;
        return [self.districts[selectedRow] subdistricts].count;

    }
}
#pragma mark - 对每个cell的数据进行设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == self.leftTable) {
        YYLeftCell *cell = [YYLeftCell cellWithTabelView:tableView];

        // 1 先取出模型
        YYSmallCityModel *model = self.districts[indexPath.row];

        // 2 如果有小的区县，则显示右边的箭头
        if (model.subdistricts.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = model.name;

        return cell;
    }else{

        NSUInteger selectedRow = [self.leftTable indexPathForSelectedRow].row;
        YYSmallCityModel *smallModel = self.districts[selectedRow];

        NSArray *tempArray  = smallModel.subdistricts;

        YYRightCell *cell = [YYRightCell cellWithTabelView:tableView];

        cell.textLabel.text = tempArray[indexPath.row];
        return cell;
    }
}

#pragma mark - 切换城市
- (IBAction)changeCity {
    // 先销毁之前弹出的框框
    [self dismissViewControllerAnimated:YES completion:nil];
    // 1 跳出一个新的控制器来
    YYChangecityController *changeVC = [[YYChangecityController alloc]init];
    YYNavigationController *nav = [[YYNavigationController alloc]initWithRootViewController:changeVC];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 代理方法，当左边被点击的时候，加载右边
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTable) {
        // 1 刷新右边数据
        [self.rightTable reloadData];
        // 2 如果没有小的区或者县，则直接销毁弹出的控制器
        YYSmallCityModel *smallModel = self.districts[indexPath.row];
        if (!smallModel.subdistricts.count) {
            [self dismissViewControllerAnimated:YES completion:nil];
            // 3 这里也应该发出通知，当右边tableView没有内容的时候，也应该发送通知
            NSString *smallTitle = smallModel.name;
            NSDictionary *infoDict = @{YYSmallCitySmallNameDidChangeKey:smallTitle};
            [YYNoteCenter postNotificationName:YYSmallCityDidChangeNotification object:nil userInfo:infoDict];

        }

            }else{
        // 如果是右边的行被点击了，则左边的区和右边的内容传到导航栏上

        // 1 这里需要发出通知，将标题和子标题的内容都传过去
        NSUInteger selectedRow = [self.leftTable indexPathForSelectedRow].row;
        YYSmallCityModel *small = self.districts[selectedRow];

        // 传过去再拼接好了
        NSString *title = small.name;
        NSString *smallTitle = small.subdistricts[indexPath.row];
        // 2 通知发出去了
        NSDictionary *infoDict = @{YYSmallCityNameDidChangeKey:title,YYSmallCitySmallNameDidChangeKey:smallTitle};
        [YYNoteCenter postNotificationName:YYSmallCityDidChangeNotification object:nil userInfo:infoDict];

        // 3 再销毁弹窗
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

@end
