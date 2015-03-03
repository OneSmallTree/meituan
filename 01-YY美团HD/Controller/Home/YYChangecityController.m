//
//  YYChangecityController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/6.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//  这里用的是citygRroup数据源

#import "YYChangecityController.h"
#import "UIBarButtonItem+YYTwoImageBarItem.h"
#import "YYCityGroupModel.h"
#import "YYDataTool.h"
#import "YYCityModel.h"

@interface YYChangecityController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation YYChangecityController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_navigation_close" highImg:@"btn_navigation_close_hl" target:self action:@selector(closeChange)];

    self.tableView.sectionIndexColor = [UIColor blackColor];
}

#pragma mark - 关闭切换城市的弹出框
- (void)closeChange
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[YYDataTool cityGroup] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[YYDataTool cityGroup][section] cities].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"changeCitycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YYCityGroupModel *model = [YYDataTool cityGroup][indexPath.section];
    cell.textLabel.text = model.cities[indexPath.row];
    return cell;

}

#pragma mark - 代理方法，设置头部标题等
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[YYDataTool cityGroup][section] title];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[YYDataTool cityGroup] valueForKeyPath:@"title"];
}
#pragma mark - 当点击了切换的城市后，这里传过去的要是YYcityModel类型，
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1 使自己（窗口）消失
    [self dismissViewControllerAnimated:YES completion:nil];

    // 2 得到被点击的行数的模型中的文字
    YYCityGroupModel *model = [YYDataTool cityGroup][indexPath.section];
    NSString *cityName = model.cities[indexPath.row];

    // 3 通过得到的城市名字，得到城市模型？
    YYCityModel *cityModel = [YYDataTool cityWithCityName:cityName];

    // 4 发出通知 将点击的城市同步到导航栏上
    NSDictionary *infoDict = @{YYCityDidChangeKey:cityModel};
    [YYNoteCenter postNotificationName:YYCityDidChangeNotification object:nil userInfo:infoDict];
}

@end
