//
//  ThreadControllVC.m
//  YaPi
//
//  Created by 曹后红 on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//  控制线程通信

#import "ThreadControllVC.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
#define IMAGE_COUNT 9

@interface ThreadControllVC ()
{
    NSMutableArray *_imageViewsArray;
    NSCondition *_condition;
}
@end

@implementation ThreadControllVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle:@"控制线程通信"];
    [self layoutUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

//界面布局
- (void)layoutUI
{
    //创建多个图片控件用于显示图片
    _imageViewsArray = [NSMutableArray array];
    for (int r = 0 ; r < ROW_COUNT; r++) {
        for (int c = 0; c < COLUMN_COUNT; c++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(c*(ROW_WIDTH + CELL_SPACING), r*(ROW_HEIGHT + CELL_SPACING), ROW_WIDTH, ROW_HEIGHT)];
            [self.mMainView addSubview:imageView];
            [_imageViewsArray addObject:imageView];
        }
    }
    
    UIButton *btnLoad=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLoad.frame=CGRectMake(50, 500, 100, 25);
    [btnLoad setTitle:@"加载图片" forState:UIControlStateNormal];
    [btnLoad addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLoad];
    
    UIButton *btnCreate=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCreate.frame=CGRectMake(160, 500, 100, 25);
    [btnCreate setTitle:@"创建图片" forState:UIControlStateNormal];
    [btnCreate addTarget:self action:@selector(createImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreate];
    
    //创建图片链接
    _imageNamesArray = [NSMutableArray array];
    
    //初始化锁对象
    _condition = [[NSCondition alloc] init];
    
    _currentIndex = 1;
    
    
}
#pragma mark - 多线程下载图片
- (void)loadImageWithMultiThread {
    int count = ROW_COUNT * COLUMN_COUNT;
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i < count; i++) {
        //加载图片
        dispatch_async(globalQueue, ^{
            [self loadImage:i];
        });
    }
    
}

//异步创建一张图片链接
- (void)createImageWithMultiThread {
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建图片链接
    dispatch_async(globalQueue, ^{
        [self creatImageName];
    });
}

- (void)loadImage:(int)index
{
    //加锁
    [_condition lock];
    
    //如果当前有图片资源则加载，否则等待
    if (_imageNamesArray.count > 0) {
        [self loadAndUpdataImageWithIndex:index];
        [_condition broadcast];
    }else
    {
        //线程等待
        [_condition wait];
        
        //一旦创建完成图片立即加载
        [self loadAndUpdataImageWithIndex:index];
    }
    
    // 解锁
    [_condition unlock];
    
}

//加载图片并将图片显示到界面
- (void)loadAndUpdataImageWithIndex:(int)index
{
    //请求数据
    NSData *data = [self requestData:index];
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        UIImage *image = [UIImage imageWithData:data];
        UIImageView *imageView = _imageViewsArray[index];
        imageView.image = image;
    });
}

//请求图片数据
- (NSData *)requestData:(int)index
{
    NSData *data;
    NSString *name;
    name=[_imageNamesArray lastObject];
    [_imageNamesArray removeObject:name];
    if(name){
        NSURL *url=[NSURL URLWithString:name];
        data=[NSData dataWithContentsOfURL:url];
    }
    return data;
}

//创建图片
- (void)creatImageName
{
    [_condition lock];
    //如果当前已经有图片了则不再创建，线程处于等待状态
    if(_imageNamesArray.count > 0)
    {
        [_condition wait];
    }else
    {
        //生产者，每次生产1张图片
        [_imageNamesArray addObject:[NSString stringWithFormat:@"http://pic1.win4000.com/wallpaper/120*80/2286%d.jpg",_currentIndex++]];
        
        //创建完图片则发出信号唤醒其他等待线程
        [_condition signal];
        
        [_condition wait];
        NSLog(@"I am aweak");
    
    }
    [_condition unlock];
}
@end
