//
//  NSOperationVC.m
//  YaPi
//
//  Created by 曹后红 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSOperationVC.h"
#define ROW_COUNT 3
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

@interface NSOperationVC (){
    NSMutableArray *_imageViewsArray;
    NSMutableArray *_imageNamesArray;
}
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation NSOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle:@"NSOperation"];
    [self initView];
    [self layoutUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.mMainView addSubview:_imageView];
    
    UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.frame=CGRectMake(50, self.mMainView.frame.size.height - 25, 300, 25);
    [nextButton setTitle:@"加载单个图片" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    UIButton *loadMoreButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    loadMoreButton.frame=CGRectMake(50, self.mMainView.frame.size.height, 300, 25);
    [loadMoreButton setTitle:@"加载多个图片" forState:UIControlStateNormal];
    [loadMoreButton addTarget:self action:@selector(loadMoreImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadMoreButton];
}

#pragma mark - 界面布局
- (void)layoutUI
{
    _imageViewsArray = [NSMutableArray array];
    
    for (int r = 0; r < ROW_COUNT; r++) {
        for (int c = 0 ; c < COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            //            imageView.backgroundColor=[UIColor redColor];
            [self.mMainView addSubview:imageView];
            [_imageViewsArray addObject:imageView];

        }
    }
    
    _imageNamesArray = [NSMutableArray array];
    for (int i = 0; i < ROW_COUNT*COLUMN_COUNT; i++) {
        [_imageNamesArray addObject:[NSString stringWithFormat:@"http://pic1.win4000.com/wallpaper/120*80/2286%d.jpg",i]];
    }
}
#pragma mark - NSInvocationOperation 加载单个图片
- (void)loadImageWithMultiThread {
	/*
     创建一个调用操作
     object：调用方法参数
     */
    
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadImage) object:nil];
    //创建完NSInvocationOperation对象并不会被调用，它由一个start方法启动操作，但是注意如果直接调用start方法，则此操作会在主线程中调用,一般不会这么操作，而是添加到NSOperationQueue中
//    [invocationOperation start];
    
    //创建操作队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    //注意添加到操作队列后，队列会开启一个线程执行此操作
    [operationQueue addOperation:invocationOperation];
}

- (void)loadImage
{
    NSURL *url = [NSURL URLWithString:@"http://img2.3lian.com/2014/f7/11/d/102.jpg"];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    _imageView.image = image;
}

#pragma mark - NSBlockOperation 加载多个图片
- (void)loadMoreImageWithMultiThread {
    int count = ROW_COUNT*COLUMN_COUNT;
    //创建操作队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    //设置最大并发线程
    operationQueue.maxConcurrentOperationCount = 5;
    
    //最后一个先执行
    NSBlockOperation *lastBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self loadMoreImage:[NSNumber numberWithInt:count - 1]];
    }];
    
    //创建多线程用于填充图片
    for (int i = 0; i < count - 1; i++) {
        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
            [self loadMoreImage:[NSNumber numberWithInt:i]];
        }];
        [blockOperation addDependency:lastBlockOperation];
        
        [operationQueue addOperation:blockOperation];
    }
    //将最后一个图片的加载操作加入线程队列
    [operationQueue addOperation:lastBlockOperation];
    
 /*
    //创建多个线程用于填充图片
    for (int i = 0; i < count; i++) {
        //方法1：创建操作块添加到队列
        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
            [self loadMoreImage:[NSNumber numberWithInt:i]];
        }];
        //创建操作队列
        [operationQueue addOperation:blockOperation];
        
//        //方法2:直接使用操作队列添加操作
//        [operationQueue addOperationWithBlock:^{
//            [self loadMoreImage:[NSNumber numberWithInt:i]];
//        }];
    }
    
  */
}

//加载图片
- (void)loadMoreImage:(NSNumber *)index{
    int i = (int)[index integerValue];
    
    NSData *data = [self requestData:i];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self updataImageWithData:data andIndex:i];
    }];
    
}
//请求图片数据
- (NSData *)requestData:(int) index{
     //对于多线程操作建议把线程操作放到@autoreleasepool中
    @autoreleasepool {
        NSURL *url = [NSURL URLWithString:_imageNamesArray[index]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        return data;
    }
}

//将图片显示到界面
- (void)updataImageWithData:(NSData *)data andIndex:(int)index
{
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = _imageViewsArray[index];
    imageView.image = image;
}
@end
