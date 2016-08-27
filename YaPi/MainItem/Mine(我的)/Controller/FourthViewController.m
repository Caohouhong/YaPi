//
//  FourthViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FourthViewController.h"
#import "UITableView+HHTableView.h"
#import "UserHelper.h"
#import "NSTimer+HHTimerBlock.h"
#import "MBProgressHUD.h"
#import "MJRefreshNormalHeader.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSTimer *timer;
    UILabel *timeLabel;
    double startTime;
    
    int seconds;
    
    UITableView *mTableView;
}

@property (atomic, assign) BOOL canceled;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    startTime = 1439413994; //开始时间 2015-8-12 21:13:14
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
    //顶部背景图
    UIImageView *timeBgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40*UIRate)];
    timeBgImg.image = [UIImage imageNamed:@"bg_time"];
    [self.view addSubview:timeBgImg];
    
    //计时label
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40*UIRate)];
    timeLabel.font = IOS7_Font(18*UIRate);
    timeLabel.textColor = [UIColor colorWithRed:0.9 green:0.6 blue:0.9 alpha:1];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [timeBgImg addSubview:timeLabel];
    
    //tableView
   mTableView = [UITableView initWithTableView:CGRectMake(0, 40*UIRate, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 40*UIRate) withDelegate:self];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    mTableView.tableFooterView  = footerView;
    
    [self.view addSubview:mTableView];
    
    
    //刷新
    mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [mTableView.mj_header beginRefreshing];
    
    //初始化计时器
    __weak FourthViewController *weakSelf = self;
    timer = [NSTimer hh_scheduledTimerWithTimeInterval:1
                                                 block:^{
                                                     FourthViewController *strongSelf = weakSelf;
                                                     [strongSelf count];
                                                 }
                                               repeats:YES];
    
}

#pragma mark - UITabelViewDelegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"mineCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"]
                      placeholderImage:[UIImage imageNamed:@"jt_default_header"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.bezelView.color = [UIColor lightGrayColor];
        // Set the label text.
        hud.label.text = NSLocalizedString(@"正在加载...", @"HUD loading title");
        // You can also adjust other label properties if needed.
        // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            [self doSomeWork];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        });

    }
    if (indexPath.row == 1) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        

        // Set the bar determinate mode to show task progress.
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            // Do something useful in the background and update the HUD periodically.
            [self doSomeWorkWithProgress];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        });
    }
    
    if (indexPath.row == 2) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Set the label text.
        hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
        // Set the details label text. Let's make it multiline this time.
        hud.detailsLabel.text = NSLocalizedString(@"Parsing data\n(1/1)", @"HUD title");
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            [self doSomeWork];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        });

    }
}

- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(3.);
}

- (void)doSomeWorkWithProgress {
    self.canceled = NO;
    // This just increases the progress indicator in a loop.
    float progress = 0.0f;
    while (progress < 1.0f) {
        if (self.canceled) break;
        progress += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            [MBProgressHUD HUDForView:self.navigationController.view].progress = progress;
        });
        usleep(50000);
    }
}

//计时
- (void)count {
    seconds++;
    if (seconds%4 == 3) {
        [mTableView.mj_header endRefreshing];
    }
    NSDate *date = [NSDate date];//获得当前时间（UTC时间／世界统一时间）
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//获得系统时区
    NSInteger interval = [zone secondsFromGMT];//计算系统时区和UTC的差距／秒
    NSDate *localDate = [date dateByAddingTimeInterval:interval];//系统时间
    NSTimeInterval currentTimeStamp = localDate.timeIntervalSince1970;//转化成时间戳
    
    NSString *timeStr = [UserHelper getHomeFormateIntevalTime:currentTimeStamp - startTime];
    timeLabel.text = [NSString stringWithFormat:@"我和小磊子在一起%@了",timeStr];

}

- (void)loadNewData {
    NSLog(@"刷新了");
}

@end
