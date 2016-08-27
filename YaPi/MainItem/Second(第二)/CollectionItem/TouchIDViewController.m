//
//  TouchIDViewController.m
//  YaPi
//
//  Created by 曹后红 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TouchIDViewController.h"
//TouchId Framework 不知为何倒入框架后不可自动引用
#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LAError.h>

@interface TouchIDViewController ()

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle:@"TouchID"];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView
{
    UIButton *touchIDBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    touchIDBtn.frame = CGRectMake((SCREEN_WIDTH - 100*UIRate)/2, SCREEN_HEIGHT/2 - 25*UIRate, 100*UIRate, 50*UIRate);
    [touchIDBtn setTitle:@"Touch ID" forState:UIControlStateNormal];
    touchIDBtn.backgroundColor = UIColorFromRGB(0x3caafa);
    touchIDBtn.layer.cornerRadius = 5;
    [touchIDBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [touchIDBtn addTarget:self action:@selector(touchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mMainView addSubview:touchIDBtn];
}
- (void)touchBtnAction {
    
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    //错误对象
    NSError* error = nil;
    NSString* result = @"Authentication is needed to access your notes.";
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self showHint:@"success"];
                }];
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"Authentication was cancelled by the user");
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"User selected to enter custom password");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
    
}


@end
