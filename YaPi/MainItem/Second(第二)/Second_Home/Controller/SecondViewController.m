//
//  SecondViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/7/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SecondViewController.h"
#import "UserConnect.h"
#import "MoreMainnViewCollectionViewCell.h"
#import "TouchIDViewController.h"
#import "NSThreadTestVC.h"
#import "BaseWebViewController.h"

@interface SecondViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"系统功能";
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    double itemSize = (SCREEN_WIDTH - 1.5*UIRate)/4;
    layout.itemSize = CGSizeMake(itemSize, itemSize);
    layout.minimumLineSpacing = 0.5*UIRate;
    layout.minimumInteritemSpacing = 0;
    
    //通过布局类创建一个collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH/4.0*3 + 1.5*UIRate) collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor greenColor];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[MoreMainnViewCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview:collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreMainnViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    [cell initWithIndex:indexPath.row andType:CollectionCellTypeSystemFunc];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        //TouchID
        case 0:
        {
            TouchIDViewController *touchIDVC = [[TouchIDViewController alloc] init];
            [self.navigationController pushViewController:touchIDVC animated:YES];
        }
            break;
        //多线程
        case 1:
        {
            NSThreadTestVC *threadTestVC = [[NSThreadTestVC alloc] init];
            [self.navigationController pushViewController:threadTestVC animated:YES];
        }
            break;
        
        case 2:
        {
           
        }
            break;
        
        case 3:
        {

        }
            break;
        default:
            break;
    }
}
@end
