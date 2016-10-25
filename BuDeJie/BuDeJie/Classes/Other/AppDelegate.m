//
//  AppDelegate.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "AppDelegate.h"
#import "BRAdViewController.h"
#import "AFNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // ----设置跟控制器
    [self setRootViewController];
    
    
    // ----监听网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return YES;
    
}



- (void)setRootViewController
{
    self.window                    = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    BRAdViewController *adVC       = [[BRAdViewController alloc] init];

    self.window.rootViewController = adVC;

    [self.window makeKeyAndVisible];
    
}

@end
