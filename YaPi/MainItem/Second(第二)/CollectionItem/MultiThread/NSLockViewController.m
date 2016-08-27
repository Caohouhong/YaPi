//
//  NSLockViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//  同步锁解决资源抢占的问题1:NSLock 2:@synchronized

#import "NSLockViewController.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
#define IMAGE_COUNT 9

@interface NSLockViewController ()
{
    NSMutableArray *_imageViewsArray;
    NSLock *_lock;//同步锁
    dispatch_semaphore_t _semaphore;//定义一个信号量
}
@end

@implementation NSLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle:@"NSLock"];
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)layoutUI
{
    //创建多个图片控件用于显示图片
    _imageViewsArray = [NSMutableArray array];
    for (int r = 0; r < ROW_COUNT; r++) {
        for (int c = 0; c < COLUMN_COUNT; c++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(c*(ROW_WIDTH + CELL_SPACING), r*(ROW_HEIGHT + CELL_SPACING) , ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode = UIViewContentModeScaleToFill;
            [self.mMainView addSubview:imageView];
            [_imageViewsArray addObject:imageView];
        }
    }
    
    //创建图片链接
    _imageNamesArray = [NSMutableArray array];
    for (int i = 1; i < IMAGE_COUNT + 1; i++) {
        [_imageNamesArray addObject:[NSString stringWithFormat:@"http://img.ivsky.com/img/bizhi/t/201108/10/katong_fengjing-00%d.jpg",i]];
    }
    
    //创建按钮
    UIButton *button = [[UIButton alloc ] initWithFrame:CGRectMake((SCREEN_WIDTH - 300)/2, SCREEN_HEIGHT - 200, 300, 50)];
    button.layer.cornerRadius = 5;
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //初始化锁对象
    _lock = [[NSLock alloc] init];
    
    /*
     初始化信号量
     参数是信号量初始值
     */
    _semaphore = dispatch_semaphore_create(1);
    
}

//多线程下载图片
- (void)loadImageWithMultiThread {
    int count = ROW_COUNT * COLUMN_COUNT;
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建多个线程用于填充图片
    for (int i = 0; i < count; i++) {
        dispatch_async(globalQueue, ^{
            [self loadImage:i];
        });
    }
}

//加载图片
- (void)loadImage:(int)index
{
    //请求数据
    NSData *data = [self requestData:index];
    
    //更新UI界面，此处调用GCD主线程队列的方法
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        [self updataImageWithData:data andIndex:index];
    });
    
}

//请求图片数据
- (NSData *)requestData:(int)index
{
    NSData *data;
    NSString *name;
  
/* 方法1:解决线程同步问题
    //加锁
    [_lock lock];
    
    if (_imageNamesArray.count > 0) {
        name =[ _imageNamesArray lastObject];
        [_imageNamesArray removeObject:name];
    }
    //使用完解锁
    [_lock unlock];
*/
 
/*
//方法2:使用@synchronized
    //线程同步
    @synchronized (self) {
        if (_imageNamesArray.count > 0) {
            name =[ _imageNamesArray lastObject];
            [_imageNamesArray removeObject:name];
        }
    }
 */
    
//方法3:GCD中的信号量解决
    //信号等待， 第二个参数：等待时间
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if (_imageNamesArray.count > 0) {
        name =[ _imageNamesArray lastObject];
        [_imageNamesArray removeObject:name];
    }
    dispatch_semaphore_signal(_semaphore);
    
    if(name)
    {
        NSURL *url = [NSURL URLWithString:name];
        data = [NSData dataWithContentsOfURL:url];
    }
    return data;
}

//更新UI界面
- (void)updataImageWithData:(NSData *)data andIndex:(int)index
{
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = _imageViewsArray[index];
    imageView.image = image;
}

@end
