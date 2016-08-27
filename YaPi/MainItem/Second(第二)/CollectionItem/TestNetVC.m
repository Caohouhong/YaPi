//
//  TestNetVC.m
//  YaPi
//
//  Created by 曹后红 on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TestNetVC.h"
#import "UserConnect.h"
#import "MJRefreshAutoNormalFooter.h"
#import "MJRefreshNormalHeader.h"

@interface TestNetVC()
{
    UIScrollView *scrollView;
}
@end

@implementation TestNetVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"网络测试";
    [self initView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT );
    scrollView.clipsToBounds = YES;
    scrollView.backgroundColor = RGBCOLOR(210, 210, 210);
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUpData)];
    [self.mMainView addSubview:scrollView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height - 20*UIRate, SCREEN_WIDTH, 20*UIRate)];
    label.font = IOS7_Font(15*UIRate);
    label.textColor = UIColorFromRGB(0x3caafa);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"这是一个label";
    [scrollView addSubview:label];
    
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, SCREEN_HEIGHT/2 , 100*UIRate, 50*UIRate)];
    bottomButton.backgroundColor = UIColorFromRGB(0x3caafa);
    [bottomButton setTitle:@"请求数据" forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(bottomButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:bottomButton];
    
}

- (void)bottomButtonAction {
    [self requestData];
}

- (void)requestData
{
    
    [self showHudInView:self.view hint:@"正在加载..."];
    
    NSMutableDictionary *params = [UserConnect getBaseRequestParams];
    
    [UserConnect testUrlRequset:params success:^(NSURLSessionDataTask *dataTask, NSDictionary *responseDic) {
        
         [self hideHud];
        if ([[responseDic objectForKey:@"ret_code"] isEqualToString:@"000000"]) {
            NSLog(@"返回成功");
            [self.view makeToast:@"请求成功"];
           
        }else
        {
            NSLog(@"返回失败");
        }
        
    } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        [self hideHud];
        NSLog(@"请求失败");
        
    }];
}

//头部刷新
- (void)loadUpData {
    [self requestData];
    [scrollView.mj_header endRefreshing];
}

@end
