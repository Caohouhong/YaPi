//
//  PlayViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/7/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PlayViewController.h"
#import "MJRefreshAutoNormalFooter.h"
#import "MJRefreshNormalHeader.h"
#import "POPSpringAnimation.h"
#import "POPBasicAnimation.h"

@interface PlayViewController ()
{
    UIScrollView *scrollView;
    UIButton *toastBtn;
    UIButton *hintBtn;
}
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle:@"动画"];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollView.backgroundColor = UIColorFromRGB(0xd2d2d2);
    scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUpData)];

    [self.mMainView addSubview:scrollView];
    
    
    toastBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    toastBtn.frame = CGRectMake((SCREEN_WIDTH - 100*UIRate)/2, 50*UIRate, 100*UIRate, 40*UIRate);
    [toastBtn setTitle:@"Toast" forState:UIControlStateNormal];
    [toastBtn addTarget:self action:@selector(toastBtnAction) forControlEvents:UIControlEventTouchUpInside];
    toastBtn.backgroundColor = UIColorFromRGB(0x3caafa);
    [scrollView addSubview:toastBtn];
    
    hintBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    hintBtn.frame = CGRectMake((SCREEN_WIDTH - 100*UIRate)/2, 100*UIRate, 100*UIRate, 40*UIRate);
    [hintBtn setTitle:@"Hint" forState:UIControlStateNormal];
    [hintBtn addTarget:self action:@selector(hintBtnAction) forControlEvents:UIControlEventTouchUpInside];
    hintBtn.backgroundColor = UIColorFromRGB(0x3caafa);
    [scrollView addSubview:hintBtn];

}

- (void)loadMoreData {
    NSLog(@"上拉加载更多数据...");
    [scrollView.mj_footer endRefreshing];
}
- (void)loadUpData {
    NSLog(@"下拉刷新");
    [scrollView.mj_header endRefreshing];
}

- (void)toastBtnAction {
    
    //pop缩小用法
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    scaleAnimation.springBounciness = 10.f;
    [toastBtn.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
    
    
    //Toast点击多次会多次跳出
    [self.view makeToast:@"这是一个Toast" duration:2.0 position:CSToastPositionCenter];
    
}

- (void)hintBtnAction {
    
    //一个存在另一个就会将其覆盖
	[self showHint:@"This is a Hint"];
    
    //pop旋转
    POPSpringAnimation *rotationAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    rotationAnimation.beginTime = CACurrentMediaTime() + 0.2;
    rotationAnimation.toValue = @(1.2);
    rotationAnimation.springBounciness = 10.f;
    rotationAnimation.springSpeed = 3;
    [hintBtn.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnim"];
    
    //pop改变透明度
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.5);
    [hintBtn.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

@end
