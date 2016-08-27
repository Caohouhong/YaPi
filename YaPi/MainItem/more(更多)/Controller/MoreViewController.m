//
//  MoreViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MoreViewController.h"
#import "SDWebImageDownloader.h"
#import "MoreMainnViewCollectionViewCell.h"
#import "TestNetVC.h"
#import "BaseWebViewController.h"
#import "PlayViewController.h"

@interface MoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIImageView *imageView;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"更多";
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    double itemSize = (SCREEN_WIDTH - 1*UIRate)/3;
    layout.itemSize = CGSizeMake(itemSize, itemSize);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0.5*UIRate;
    
    //通过一个布局类layout来创建一个collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 400*UIRate) collectionViewLayout:layout];
    
    collectionView.backgroundColor = UIColorFromRGB(0xd2d2d2);
    
    //设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[MoreMainnViewCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview:collectionView];
}

//块数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每块Item个数（总个数）
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 13;
}

//cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreMainnViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%10/10.0];
    
    [cell initWithIndex:indexPath.row andType:CollectionCellTypeThirdPart];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        //AFNetworking
        case 0:
        {
            TestNetVC *testNetVC = [[TestNetVC alloc] init];
            [self.navigationController pushViewController:testNetVC animated:YES];
        }
            break;
         //MBProgressHUD
         case 1:
        {
            TestNetVC *testNetVC = [[TestNetVC alloc] init];
            [self.navigationController pushViewController:testNetVC animated:YES];

        }
            break;
        //MJRefresh
        case 2:
        {
            PlayViewController *playVC = [[PlayViewController alloc] init];
            [self.navigationController pushViewController:playVC animated:YES];

        }
            break;
        //pop
        case 3:
        {
            PlayViewController *playVC = [[PlayViewController alloc] init];
            [self.navigationController pushViewController:playVC animated:YES];
        }
            break;
        //SDWebImage
        case 4:
        {
            [self showHint:@"SDWebImage暂未实现"];
        }
            break;
        //Toast
        case 5:
        {
            PlayViewController *playVC = [[PlayViewController alloc] init];
            [self.navigationController pushViewController:playVC animated:YES];

        }
            break;
        //OC与js交互
        case 6:
        {
            BaseWebViewController *baseWebVC = [[BaseWebViewController alloc] init];
            [self.navigationController pushViewController:baseWebVC animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
