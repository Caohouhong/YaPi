//
//  TestBlockVC.m
//  YaPi
//
//  Created by 曹后红 on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TestBlockVC.h"

@implementation TestBlockVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"block";
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, SCREEN_HEIGHT/2 , 100*UIRate, 50*UIRate)];
    bottomButton.backgroundColor = UIColorFromRGB(0x3caafa);
    [bottomButton setTitle:@"返回" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(bottomButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
    self.tabBarController.tabBar.hidden = YES;

}

- (void)bottomButtonAction {
    if (self.backBlock) {
        self.backBlock(5);
    }
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
	
}


@end
