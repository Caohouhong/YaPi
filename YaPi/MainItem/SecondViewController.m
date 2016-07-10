//
//  SecondViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/7/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SecondViewController.h"
#import "TestBlockVC.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    self.navigationItem.title = @"木鸭";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2 - 100*UIRate, SCREEN_WIDTH, 50*UIRate)];
    label.font = IOS7_Font(15*UIRate);
    label.textColor = UIColorFromRGB(0x666666);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"superman";
    [self.view addSubview:label];
    
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, SCREEN_HEIGHT/2 , 100, 50)];
    bottomButton.backgroundColor = UIColorFromRGB(0x3caafa);
    [bottomButton setTitle:@"去获得" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(bottomButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)bottomButtonAction {
    TestBlockVC *testBlock = [[TestBlockVC alloc] init];
    [self.navigationController pushViewController:testBlock animated:YES];
}
@end
