//
//  ThirdViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ThirdViewController.h"

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

}

@end
