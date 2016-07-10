//
//  MainViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MainViewController.h"
#import "TestBlockVC.h"

@interface MainViewController ()
{
    UIImageView *imageView;
    UIButton *bottomButton;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    self.navigationItem.title = @"鸭屁屁";
    
    UIButton *firstButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50)/2, (SCREEN_HEIGHT - 100)/2 , 50, 100)];
    [firstButton setBackgroundImage:[UIImage imageNamed:@"beauty_btn"] forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(firstButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstButton];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"piao_xin_hui"];
    imageView.hidden = YES;
    [self.view addSubview:imageView];
    
    bottomButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, SCREEN_HEIGHT - 100 , 100, 50)];
    bottomButton.hidden = YES;
    bottomButton.backgroundColor = UIColorFromRGB(0x3caafa);
    [bottomButton setTitle:@"下一页" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(bottomButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)firstButton {
    imageView.hidden = NO;
    bottomButton.hidden = NO;
}

- (void)bottomButtonAction {
    bottomButton.hidden = YES;
    imageView.hidden = YES;
    TestBlockVC *testBlock = [[TestBlockVC alloc] init];
    [self.navigationController pushViewController:testBlock animated:YES];
    testBlock.backBlock = ^(int num){
        NSLog(@"%d",num);
    };
}
@end
