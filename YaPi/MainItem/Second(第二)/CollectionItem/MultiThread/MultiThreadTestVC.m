//
//  MultiThreadTestVC.m
//  YaPi
//
//  Created by 曹后红 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MultiThreadTestVC.h"
#import "HHImageData.h"
#define ROW_COUNT 3
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface MultiThreadTestVC ()
{
    NSMutableArray *_imageViewsArray;
    NSMutableArray *_imageNamesArray;
    NSMutableArray *_threadsArray;
    
}
@end

@implementation MultiThreadTestVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initTitle:@"多个图片加载"];
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark 界面布局
-(void)layoutUI{
    //创建多个图片控件用于显示图片
    _imageViewsArray=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            //            imageView.backgroundColor=[UIColor redColor];
            [self.mMainView addSubview:imageView];
            [_imageViewsArray addObject:imageView];
            
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //停止按钮
    UIButton *buttonStop=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonStop.frame=CGRectMake(200, 500, 100, 25);
    [buttonStop setTitle:@"停止加载" forState:UIControlStateNormal];
    [buttonStop addTarget:self action:@selector(stopLoadImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonStop];
    
    _imageNamesArray = [NSMutableArray array];
    for(int i = 0; i < ROW_COUNT*COLUMN_COUNT; i++) {
        [_imageNamesArray addObject:[NSString stringWithFormat:@"http://pic1.win4000.com/wallpaper/120*80/2286%d.jpg",i]];
    }
    
}

#pragma mark 将图片显示到界面
-(void)updateImage:(HHImageData *)imageData{
    UIImage *image=[UIImage imageWithData:imageData.imageData];
    UIImageView *imageView= _imageViewsArray[imageData.index];
    imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    //对于多线程操作建议把线程操作放到@autoreleasepool中
    @autoreleasepool {
        
        NSURL *url=[NSURL URLWithString:_imageNamesArray[index]];
        NSData *data=[NSData dataWithContentsOfURL:url];
        return data;
    }
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    //currentThread方法可以取得当前操作线程
    NSLog(@"current thread:%@",[NSThread currentThread]);
    
    int i = [index integerValue];
    
    NSLog(@"加载的图片%i",i);//未必按顺序输出
    
    NSData *data= [self requestData:i];
    
    //当前线程
    NSThread *currentThread = [NSThread currentThread];
    
    //如果当前线程是取消状态，则退出当前线程
    if (currentThread.isCancelled) {
        
        [NSThread exit];//取消当前线程
    }
    
    HHImageData *imageData=[[HHImageData alloc] init];
    imageData.index = i;
    imageData.imageData = data;
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:imageData waitUntilDone:YES];
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    
    int count = ROW_COUNT*COLUMN_COUNT;
/*
    //后台加载(NSThread的扩展)
    for (int i = 0; i < count; ++i) {
        [self performSelectorInBackground:@selector(loadImage:) withObject:[NSNumber numberWithInt:i]];
    }
  */
    
   
    _threadsArray = [NSMutableArray array];
    
    //创建多个线程用于填充图片
    for (int i = 0; i < count; ++i) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
        thread.name = [NSString stringWithFormat:@"myThread %i",i];//设置线程名字
        if (i == count - 1) {
            thread.threadPriority = 1.0;
        }else
        {
            thread.threadPriority = 0.0;
        }
        [_threadsArray addObject:thread];
        
    }
    //循环启动线程
    for (int i = 0; i < count; i++) {
        NSThread *thread = _threadsArray[i];
        [thread start];
    }
  
}

#pragma mark - 停止加载图片
- (void)stopLoadImage {
    for (int i = 0; i< ROW_COUNT*COLUMN_COUNT; i++) {
        NSThread *thread = _threadsArray[i];
        //判断线程是否完成，如果没有完成则设置为取消状态
        //注意设置为取消状态仅仅是改变了线程的状态而言，并不能终止线程。
        if (!thread.isFinished) {
            [thread cancel];
        }
    }
     
}
@end
