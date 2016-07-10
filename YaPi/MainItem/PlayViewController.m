//
//  PlayViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/7/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView
{
    [self initTitle:@"动画"];
    self.view.backgroundColor = [UIColor whiteColor];
}
@end
