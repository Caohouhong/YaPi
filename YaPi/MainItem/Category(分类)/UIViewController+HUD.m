//
//  UIViewController+HUD.m
//  YaPi
//
//  Created by 曹后红 on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//  参考环信

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;
@implementation UIViewController (HUD)
- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = hint;
    
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.bezelView.color = [UIColor blackColor];
    hud.label.textColor = [UIColor whiteColor];
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
//    hud.yOffset += yOffset;
    [hud setOffset:CGPointMake(0, yOffset)];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}

@end
