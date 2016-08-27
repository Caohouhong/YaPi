//
//  UIViewController+HUD.h
//  YaPi
//
//  Created by 曹后红 on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//  参考环信

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

/// 在当前view上显示Hint，持续时间2.0s
- (void)showHint:(NSString *)hint;

/// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)hideHud;
@end
