//
//  AppDelegate.m
//  YaPi
//
//  Created by 曹后红 on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:3.0];
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    MainViewController *aVC = [[MainViewController alloc] init];
//    UIViewController *rootVC = [[UINavigationController alloc] initWithRootViewController:aVC];
//    self.window.rootViewController = rootVC;
    
    //初始化tabbar控制器
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    //设置控制器为window的根控制器
    self.window.rootViewController = tabBarController;
    
    //创建字控制器
    MainViewController *VC1 = [[MainViewController alloc] init];
    VC1.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *contantNav1 = [[UINavigationController alloc] initWithRootViewController:VC1];
    VC1.tabBarItem.title = @"金鸭";
    VC1.tabBarItem.image = [[UIImage imageNamed:@"tabbar_icon1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    SecondViewController *VC2 = [[SecondViewController alloc] init];
    VC2.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *contantNav2 = [[UINavigationController alloc] initWithRootViewController:VC2];
    VC2.tabBarItem.title = @"木鸭";
    VC2.tabBarItem.image = [[UIImage imageNamed:@"tabbar_icon2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ThirdViewController *VC3 = [[ThirdViewController alloc] init];
    VC3.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *contantNav3 = [[UINavigationController alloc] initWithRootViewController:VC3];
    VC3.tabBarItem.title = @"水鸭";
    VC3.tabBarItem.image = [[UIImage imageNamed:@"tabbar_icon3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FourthViewController *VC4 = [[FourthViewController alloc] init];
    VC4.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *contantNav4 = [[UINavigationController alloc] initWithRootViewController:VC4];
    VC4.tabBarItem.title = @"火鸭";
    VC4.tabBarItem.image = [[UIImage imageNamed:@"tabbar_icon4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FifthViewController *VC5 = [[FifthViewController alloc] init];
    VC5.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *contantNav5 = [[UINavigationController alloc] initWithRootViewController:VC5];
    VC5.tabBarItem.title = @"土鸭";
    VC5.tabBarItem.image = [[UIImage imageNamed:@"tabbar_icon5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabBarController.viewControllers = @[contantNav1,contantNav2,contantNav3,contantNav4,contantNav5];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
   
}

@end
