//
//  MainViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MainViewController.h"
#import "UserHelper.h"
#import "NSTimer+HHTimerBlock.h"

@interface MainViewController ()<UIScrollViewDelegate>
{
    //计时器
    NSTimer *timer;
    //开始时间
    double startTime;
    
    UILabel *timeLabel;
    
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"首页";
    startTime = 1470575773.727008;//开始时间
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
- (void)initView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, (667 - 64 - 48)*UIRate);
    scrollView.backgroundColor = UIColorFromRGB(0xd2d2d2);
    scrollView.delegate = self;

    [self.view addSubview:scrollView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20*UIRate)];
    label.font = IOS7_Font(15*UIRate);
    label.textColor = UIColorFromRGB(0x3caafa);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"这是一个label";
    [scrollView addSubview:label];

    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (667 - 64 - 48)*UIRate - 20*UIRate, SCREEN_WIDTH, 20*UIRate)];
    timeLabel.font = IOS7_Font(16*UIRate);
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:timeLabel];
    
    //计时器
    __weak MainViewController *weakSelf = self;
    
    timer = [NSTimer hh_scheduledTimerWithTimeInterval:1.0
                                                 block:^{
        
                                                     MainViewController *strongSelf = weakSelf;
                                                     [strongSelf count];
        
                                             } repeats:YES];
}

- (void)count {
    
    NSDate *current = [NSDate date];
    NSTimeInterval currentTime = current.timeIntervalSince1970;
    
    NSString *timeStr = [UserHelper getHomeFormateIntevalTime:currentTime - startTime];
    
    timeLabel.text = [NSString stringWithFormat:@"本App已平稳运行%@",timeStr];
    
}

@end
