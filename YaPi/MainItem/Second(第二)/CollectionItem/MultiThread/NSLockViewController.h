//
//  NSLockViewController.h
//  YaPi
//
//  Created by 曹后红 on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface NSLockViewController : BaseViewController

/**
   在上面的代码中”抢占资源“_imageNames定义成了成员变量，这么做是不明智的，应该定义为“原子属性”。对于被抢占资源来说将其定义为原子属性是一个很好的习惯，因为有时候很难保证同一个资源不在别处读取和修改。nonatomic属性读取的是内存数据（寄存器计算好的结果），而atomic就保证直接读取寄存器的数据，这样一来就不会出现一个线程正在修改数据，而另一个线程读取了修改之前（存储在内存中）的数据，永远保证同时只有一个线程在访问一个属性。
 */
@property (atomic, strong) NSMutableArray *imageNamesArray;

@end
