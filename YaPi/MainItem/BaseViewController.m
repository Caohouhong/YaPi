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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)baseAction
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initTitle:(NSString *)title
{
    self.navigationItem.title = title;
}
@end
