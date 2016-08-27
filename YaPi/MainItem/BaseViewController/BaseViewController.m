//
//  BaseViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/7/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES; //push时隐藏底部Tabbar
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseSetting];
    [self initBaseView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initBaseSetting
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //所有View固定从顶部开始
    self.navigationController.navigationBar.translucent = YES;
    
    //scrollView 顶部不自动让出64px
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//  self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    
    //改变左侧返回的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}

- (void)initBaseView
{
    _mMainView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _mMainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mMainView];

}
- (void)initTitle:(NSString *)title
{
    self.navigationItem.title = title;
}
@end
