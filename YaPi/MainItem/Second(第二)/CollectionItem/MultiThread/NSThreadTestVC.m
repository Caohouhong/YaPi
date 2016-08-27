//
//  NSThreadTestVC.m
//  YaPi
//
//  Created by 曹后红 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSThreadTestVC.h"
#import "MultiThreadTestVC.h"
#import "NSOperationVC.h"
#import "GCDViewController.h"
#import "NSLockViewController.h"
#import "ThreadControllVC.h"

@interface NSThreadTestVC ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation NSThreadTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle:@"多线程"];
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

#pragma mark 界面布局
-(void)layoutUI{
    
    _imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.mMainView addSubview:_imageView];
    
    UIButton *NSLockButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSLockButton.frame=CGRectMake(50, self.mMainView.frame.size.height + 25, 300, 25);
    [NSLockButton setTitle:@"跳转NSLock" forState:UIControlStateNormal];
    [NSLockButton addTarget:self action:@selector(NSLockButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NSLockButton];
    
    UIButton *GCDButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    GCDButton.frame=CGRectMake(50, self.mMainView.frame.size.height, 300, 25);
    [GCDButton setTitle:@"跳转GCD" forState:UIControlStateNormal];
    [GCDButton addTarget:self action:@selector(GCDButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:GCDButton];
    
    UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.frame=CGRectMake(50, self.mMainView.frame.size.height - 25, 300, 25);
    [nextButton setTitle:@"跳转MultiThread" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    UIButton *operationButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    operationButton.frame=CGRectMake(50, self.mMainView.frame.size.height - 50, 300, 25);
    [operationButton setTitle:@"跳转NSOperation" forState:UIControlStateNormal];
    [operationButton addTarget:self action:@selector(operationButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:operationButton];
    
    UIButton *threadButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    threadButton.frame=CGRectMake(50, self.mMainView.frame.size.height - 75, 300, 25);
    [threadButton setTitle:@"跳转ThreadControll" forState:UIControlStateNormal];
    [threadButton addTarget:self action:@selector(threadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:threadButton];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark 将图片显示到界面
-(void)updateImage:(NSData *)imageData{
    UIImage *image=[UIImage imageWithData:imageData];
    _imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData{
    //对于多线程操作建议把线程操作放到@autoreleasepool中
    @autoreleasepool {
        NSURL *url=[NSURL URLWithString:@"http://image.tianjimedia.com/uploadImages/2013/151/1704AOA3229V.jpg"];
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSLog(@"%@",data);
        return data;
    }
}

#pragma mark 加载图片
-(void)loadImage{
    //请求数据
    NSData *data= [self requestData];
    /*将数据显示到UI控件,注意只能在主线程中更新UI,
     另外performSelectorOnMainThread方法是NSObject的分类方法，每个NSObject对象都有此方法，
     它调用的selector方法是当前调用控件的方法，例如使用UIImageView调用的时候selector就是UIImageView的方法
     Object：代表调用方法的参数,不过只能传递一个参数(如果有多个参数请使用对象进行封装)
     waitUntilDone:是否线程任务完成执行
     */
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:data waitUntilDone:YES];
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    //方法1：使用对象方法
    //创建一个线程，第一个参数是请求的操作，第二个参数是操作方法的参数
    //    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage) object:nil];
    //    //启动一个线程，注意启动一个线程并非就一定立即执行，而是处于就绪状态，当系统调度时才真正执行
    //    [thread start];
    
    //方法2：使用类方法
    [NSThread detachNewThreadSelector:@selector(loadImage) toTarget:self withObject:nil];
}


- (void)nextButtonAction {
    MultiThreadTestVC *multiThreadVC = [[MultiThreadTestVC alloc] init];
    [self.navigationController pushViewController:multiThreadVC animated:YES];
}

- (void)operationButtonAction {
    NSOperationVC *operationVC = [[NSOperationVC alloc] init];
    [self.navigationController pushViewController:operationVC animated:YES];
 }

- (void)GCDButtonAction {
    GCDViewController *GCDVC = [[GCDViewController alloc] init];
    [self.navigationController pushViewController:GCDVC animated:YES];
}

- (void)NSLockButtonAction {
    NSLockViewController *lockVC = [[NSLockViewController alloc] init];
    [self.navigationController pushViewController:lockVC animated:YES];
}

- (void)threadButtonAction {
    ThreadControllVC *threadVC = [[ThreadControllVC alloc] init];
    [self.navigationController pushViewController:threadVC animated:YES];
}
@end
