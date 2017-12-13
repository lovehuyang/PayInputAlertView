//
//  ViewController.m
//  PayInputAlertView
//
//  Created by tzsoft on 2017/12/13.
//  Copyright © 2017年 HLY. All rights reserved.
//

#import "ViewController.h"
#import "PayInputAlertView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *auto_Btn = [UIButton new];
    auto_Btn.frame = CGRectMake(100, 150, 100, 30);
    auto_Btn.backgroundColor = [UIColor orangeColor];
    [auto_Btn setTitle:@"自动验证" forState:UIControlStateNormal];
    [auto_Btn addTarget:self action:@selector(createAutoPayInputAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:auto_Btn];
    
    UIButton *hand_Btn = [UIButton new];
    hand_Btn.frame = CGRectMake(100, 200, 100, 30);
    hand_Btn.backgroundColor = [UIColor orangeColor];
    [hand_Btn setTitle:@"手动验证" forState:UIControlStateNormal];
    [hand_Btn addTarget:self action:@selector(createHandPayInputAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hand_Btn];
}

#pragma mark - 创建自动验证的密码弹框
- (void)createAutoPayInputAlertView{
    PayInputAlertView *payView = [[PayInputAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"主标题" subTitle:@"副标题" type:PayInputAlertView_Auto buttonArr:@[@"取消",@"确定"]];
    
    payView.verifyPassWordAuto = ^(NSString *password) {
        NSLog(@"返回密码%@",password);
    };
}

#pragma mark - 创建手动点击的密码弹框
- (void)createHandPayInputAlertView{
    PayInputAlertView *payView = [[PayInputAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"主标题" subTitle:@"副标题" type:PayInputAlertView_Hand buttonArr:@[@"取消",@"确定"]];
    payView.verifyPassWordHand = ^(NSString *password, UIButton *button) {
        NSLog(@"按钮名称：%@\n输入密码%@",button.titleLabel.text,password);
    };
}

@end
