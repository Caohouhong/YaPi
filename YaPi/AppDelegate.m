//
//  AppDelegate.m
//  YaPi
//
//  Created by 曹后红 on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "JFTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:3.0];
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    //设置控制器为window的根控制器
    self.window.rootViewController = [[JFTabBarViewController alloc] init];
    
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
