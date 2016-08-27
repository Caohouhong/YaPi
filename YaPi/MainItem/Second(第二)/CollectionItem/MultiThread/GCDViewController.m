//
//  GCDViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GCDViewController.h"
#define ROW_COUNT 3
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
#define IMAGE_COUNT 6

@interface GCDViewController ()
{
    NSMutableArray *_imageViewsArray;
    NSMutableArray *_imageNamesArray;
}
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle:@"GCD"];
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 界面布局
- (void)layoutUI
{
    _imageViewsArray = [NSMutableArray array];
    
    for (int r = 0; r < ROW_COUNT; r++) {
        for (int c = 0 ; c < COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [self.mMainView addSubview:imageView];
            [_imageViewsArray addObject:imageView];
            
        }
    }
    
    _imageNamesArray = [NSMutableArray array];
    for (int i = 0; i < IMAGE_COUNT; i++) {
        [_imageNamesArray addObject:[NSString stringWithFormat:@"http://pic1.win4000.com/wallpaper/120*80/2286%d.jpg",i]];
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithGCD) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - 多线程下载图片
- (void)loadImageWithGCD {
    int count = ROW_COUNT*COLUMN_COUNT;
    
    /*
     创建一个串行队列
     第一个参数名：队列名称
     第二个参数名：队列类型
     */
    //注意queue对象不是指针类型
    
//    dispatch_queue_t serialQueue = dispatch_queue_create("myThreadQueue1", DISPATCH_QUEUE_SERIAL);
    
    
    /*
     取得全局队列
     第一个参数：线程优先级
     第二个参数：标记参数，目前没有用，一般传入0
     */
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建多个线程用于填充图片
    for (int i = 0; i < count; ++i) {
        //异步执行队列任务
        dispatch_async(globalQueue, ^{
            [self loadImage:[NSNumber numberWithInt:i]];
        });
        
    }
}

- (void)loadImage:(NSNumber *)index
{
    int i = (int)[index integerValue];
    //请求数据
    NSData *data = [self requestData:i];
    //更新UI界面，这里调用了GCD主线程队列的方法
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        [self updataImageWithImageData:data andIndex:i];
    });
    
}

//请求图片资源
- (NSData *)requestData:(int)index
{
    NSData *data;
    NSString *name;
    if (_imageNamesArray.count > 0) {
        name = [_imageNamesArray lastObject];
        [_imageNamesArray removeObject:name];
    }
    if (name) {
        NSURL *url = [NSURL URLWithString:name];
        data = [NSData dataWithContentsOfURL:url];
    }
    return data;
}

//将图片显示到界面
- (void)updataImageWithImageData:(NSData *)data andIndex:(int)index
{
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = _imageViewsArray[index];
    imageView.image = image;
}

@end
