//
//  BRMainViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRMainViewController.h"
#import "BREssenceViewController.h"
#import "BRFriendTrendViewController.h"
#import "BRNewViewController.h"
#import "BRPublishViewController.h"
#import "BRMeViewController.h"
#import "BRTabBar.h"
#import "BRNavigationController.h"

@implementation BRMainViewController


/** 设置颜色和字体大小*/
+ (void)load
{
    UITabBarItem *item           = [UITabBarItem appearanceWhenContainedIn:self, nil];


    /** 字体大小只能设置正常模式状态的大小！！！*/
    NSMutableDictionary *fontDic = [NSMutableDictionary dictionary];

    fontDic[NSFontAttributeName] = [UIFont systemFontOfSize:13];

    [item setTitleTextAttributes:fontDic forState:UIControlStateNormal];

    
    /** 设置选中颜色*/
    UITabBar *bar                = [UITabBar appearanceWhenContainedIn:self, nil];
    bar.tintColor                = [UIColor blackColor];
    
}


- (void)viewDidLoad
{
    /** 0.设置自定义tabBar*/
    [self setCustomTabBar];
    
    
    /** 1.添加tabBar子控制器*/
    [self setSubViewControllers];
    
    
    /** 2.添加tabBar上按钮的内容*/
    [self setTitleBtnsAttributes];
    
}


/** 设定自定义tabBar*/
- (void)setCustomTabBar
{
    BRTabBar *tabBar = [[BRTabBar alloc] init];
    
    [self setValue:tabBar forKey:@"tabBar"];
}



/** 设置子控制器*/
- (void)setSubViewControllers
{
    // ----1.精华模块
    BREssenceViewController *essenceVC         = [[BREssenceViewController alloc] init];
    UINavigationController *navEssence         = [[UINavigationController alloc] initWithRootViewController:essenceVC];
    

    // ----2.新帖模块
    BRNewViewController *newVC                 = [[BRNewViewController alloc] init];
    BRNavigationController *navNew             = [[BRNavigationController alloc] initWithRootViewController:newVC];

    
    // ----3.关注模块
    BRFriendTrendViewController *friendTrendVC = [[BRFriendTrendViewController alloc] init];
    BRNavigationController *navFriendTrend     = [[BRNavigationController alloc] initWithRootViewController:friendTrendVC];


    // ----4.我的模块
    BRMeViewController *meVC                   = [[BRMeViewController alloc] init];
    BRNavigationController *navMe              = [[BRNavigationController alloc] initWithRootViewController:meVC];
    
    
    self.viewControllers                       = @[navEssence, navNew, navFriendTrend, navMe];
    
}



/** 设置tabBar上按钮的类容*/
- (void)setTitleBtnsAttributes
{
    BRNavigationController *nav1 = self.viewControllers[0];
    nav1.tabBarItem.title        = @"精华";

    [nav1.tabBarItem setImage:[UIImage imageNamed:@"tabBar_essence_icon"]];
    
    [nav1.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];



    BRNavigationController *nav2 = self.viewControllers[1];
    nav2.tabBarItem.title        = @"新帖";

    [nav2.tabBarItem setImage:[UIImage imageNamed:@"tabBar_new_icon"]];
    [nav2.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];

    
    
    BRNavigationController *nav4 = self.viewControllers[2];
    nav4.tabBarItem.title        = @"关注";

    [nav4.tabBarItem setImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"]];
    [nav4.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];



    BRNavigationController *nav5 = self.viewControllers[3];
    nav5.tabBarItem.title        = @"我";

    [nav5.tabBarItem setImage:[UIImage imageNamed:@"tabBar_me_icon"]];
    [nav5.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
  
    
}



@end
