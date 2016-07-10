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
   self.navigationItem.title = @"水鸭";
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
   UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"man1"];
    [self.view addSubview:imageView];
    
    UIButton *button = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100*UIRate/2, SCREEN_HEIGHT - 100*UIRate, 100*UIRate, 50*UIRate)];
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
