//
//  FourthViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"火鸭";
    [self initView];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    imageView.image = [UIImage imageNamed:@"img2"];
    [self.view addSubview:imageView];
    
}

@end
