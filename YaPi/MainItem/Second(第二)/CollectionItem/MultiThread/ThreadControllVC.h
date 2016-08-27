//
//  ThreadControllVC.h
//  YaPi
//
//  Created by 曹后红 on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface ThreadControllVC : BaseViewController

///图片资源存储容器
@property (atomic, strong) NSMutableArray *imageNamesArray;

///当前加载的图片索引(图片链接地址连续)
@property (atomic, assign) int currentIndex;
@end
