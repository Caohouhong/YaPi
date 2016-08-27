//
//  ThirdViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ThirdViewController.h"
#import "PlayViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title = @"商家";
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    
    UIButton *button = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100*UIRate/2, SCREEN_HEIGHT - 64 - 49 - 50*UIRate, 100*UIRate, 50*UIRate)];
    button.backgroundColor = UIColorFromRGB(0x3caafa);
    button.layer.cornerRadius = 5;
    button.titleLabel.font = IOS7_Font(15*UIRate);
    [button setTitle:@"前往动画" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction
{
    PlayViewController *playVC = [[PlayViewController alloc] init];
    playVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playVC animated:YES];
}

@end
