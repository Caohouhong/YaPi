//
//  TestBlockVC.h
//  YaPi
//
//  Created by 曹后红 on 16/7/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Block)(int);

@interface TestBlockVC : UIViewController
@property (nonatomic, copy) Block backBlock;
@end
