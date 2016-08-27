//
//  BaseViewController.h
//  YaPi
//
//  Created by 曹后红 on 16/7/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong)UIView *mMainView;

///  设置navigationBar的title
- (void)initTitle:(NSString *)title;

@end
