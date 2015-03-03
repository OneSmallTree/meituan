//
//  YYDetailController.m
//  01-YY美团HD
//
//  Created by 阳颜 on 15/2/15.
//  Copyright (c) 2015年 yangyan. All rights reserved.
//

#import "YYDetailController.h"
#import "NSString+YYCorrentCurrentPrice.h"
#import <UIView+AutoLayout.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "YYLineLabel.h"
#import "DPAPI.h"
#import "YYGetSingleDealResult.h"
#import "YYRestrictions.h"
#import "MBProgressHUD+MJ.h"
#import "YYBuysModel.h"
#import "YYBuysTool.h"
/*
 问题记录：
 1 不能用setModel方法,因为这个方法调用的时候所有控件的值还是nil 
 应该是值传过来的时候，控制器还没有创建好？？？
  */
@interface YYDetailController ()<UIWebViewDelegate>
/**
 *  浏览器
 */
@property (weak, nonatomic) IBOutlet UIWebView *webView;
/**
 *  显示正在load
 */
@property (weak,nonatomic) UIActivityIndicatorView * loadingView;
/**
 *  配图
 */
@property (weak, nonatomic) IBOutlet UIImageView *image;
/**
 *  团购标题
 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/**
 *  团购描述
 */
@property (weak, nonatomic) IBOutlet UILabel *desc;
/**
 *  团购现在的价格
 */
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
/**
 *  团购原来的价格
 */
@property (weak, nonatomic) IBOutlet YYLineLabel *pastPrice;
/**
 *  分享操作
 */
- (IBAction)shareButton:(UIButton *)sender;
/**
 *  收藏操作
 */
- (IBAction)saveButton:(UIButton *)sender;
/**
 *  支持随时退
 */
@property (weak, nonatomic) IBOutlet UIButton *unuse;
/**
 *  支持过期退
 */
@property (weak, nonatomic) IBOutlet UIButton *expiredButton;
/**
 *  已售多少份
 */
@property (weak, nonatomic) IBOutlet UIButton *buyCountButton;
/**
 *  还剩多少时间，团购结束
 */
@property (weak, nonatomic) IBOutlet UIButton *restTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@end

@implementation YYDetailController
- (IBAction)dismiss {

    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 对指示器进行懒加载
- (UIActivityIndicatorView *)loadingView
{
    if (_loadingView == nil) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.webView addSubview:loadingView];
        // 居中
        [loadingView autoCenterInSuperview];
        _loadingView = loadingView;
    }
    return _loadingView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    // 1 开始赚圈圈
    [self.loadingView startAnimating];

    self.webView.scrollView.hidden = YES;

    // 3 加载请求
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.deal_h5_url]]];
    [self setleftView];

}
#pragma mark - 支持的设备方向,会自动旋转到支持的设备方向
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - 代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     NSString *ID = [self.model.deal_id substringFromIndex:2];
    NSString *lastURL = webView.request.URL.absoluteString;
    if ([lastURL hasSuffix:ID]) { // 加载详情完毕
                // 执行JS删掉不需要的节点
                NSString *js = @"document.getElementsByTagName('header')[0].remove();"
                "document.getElementsByClassName('cost-box')[0].remove();"
                "document.getElementsByClassName('buy-now')[0].remove();";
                [webView stringByEvaluatingJavaScriptFromString:js];
                // 停止动画
                [self.loadingView stopAnimating];
                // 显示webView
                webView.scrollView.hidden = NO;
            }else
            {
                NSString *url = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
#pragma mark - 将模型数据设置到view上
- (void)setleftView
{

    // 首先判断它是否被收藏，然后设置收藏按钮的状态
    self.collectButton.selected = [YYBuysTool isCollectedBuys:self.model];

    // 1 将各控件的值进行赋值
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.model.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];

    self.name.text = self.model.title;
    self.desc.text = self.model.desc;
    self.currentPrice.text = self.model.current_price.dealPriceString;
    self.pastPrice.text = self.model.list_price;
    NSString *temp = [NSString stringWithFormat:@"已售出%@", self.model.purchase_count];
    [self.buyCountButton setTitle:temp forState:UIControlStateNormal];

    // 2 获得剩余团购时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *deadDate = [fmt dateFromString:self.model.purchase_deadline];

    // 增加一天的过期时间，为什么要增加一天的过期时间
    deadDate = [deadDate dateByAddingTimeInterval:24*60*60];

    // 比较过期时间和当前时间,获得当前用户的时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 这个是要转换成的单位
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmps = [calendar components:unit fromDate:[NSDate date] toDate:deadDate options:kNilOptions];
    // 设置剩余时间

    // 判断剩余时间，然后进行显示（未来1个月内有效，未来1年有效，如果低于一个月则之间显示剩余时间）
    NSString *dateStr = [NSString stringWithFormat:@"剩余%d天%d小时%d分",cmps.day,cmps.hour,cmps.minute];
    NSString *temp1 = @"未来一个月内有效";
    NSString *temp2 = @"未来一年内有效";
    if (cmps.day < 30) {
        [self.restTimeButton setTitle:dateStr forState:UIControlStateNormal];
    }else if(cmps.day > 365){
        [self.restTimeButton setTitle:temp2 forState:UIControlStateNormal];
    }else{
        [self.restTimeButton setTitle:temp1 forState:UIControlStateNormal];
    }
    // 3 发送请求给服务器获得随时退过期退等信息
    NSDictionary *params = @{@"deal_id":self.model.deal_id};
    [[DPAPI sharedInstance]request:@"v1/deal/get_single_deal" params:params success:^(id json) {

        YYGetSingleDealResult *result = [YYGetSingleDealResult objectWithKeyValues:json];
        self.model = [result.deals lastObject];
        // 设置按钮状态
        self.unuse.selected = self.model.is_refundable;
        self.expiredButton.selected = self.model.is_refundable;
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"找不到指定的团购信息"];
        }];
}

#pragma mark - 收藏分享按钮点击
- (IBAction)saveButton:(UIButton *)sender
{
    // 判断收藏按钮是否是选中状态,如果是选中状态就取消收藏
    if (sender.isSelected) {
        [YYBuysTool cancelCollectBuys:self.model];
    }else{
        [YYBuysTool collectBuys:self.model];
    }
    sender.selected = !sender.selected;
}

- (IBAction)shareButton:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
@end
