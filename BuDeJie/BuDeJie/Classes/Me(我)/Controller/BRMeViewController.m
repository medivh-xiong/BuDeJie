//
//  BRMeViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRMeViewController.h"
#import "UIBarButtonItem+BRBarButtonItem.h"
#import "BRSettingViewController.h"

@implementation BRMeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ----设置导航栏的样式
    [self setNavBarItem];
}




#pragma mark - 设置导航栏的样式
- (void)setNavBarItem
{
    /** 设置右边items*/
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImg:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
    
    /** 设置中间titleview*/
    self.navigationItem.title = @"我的";
    
}




- (void)setting
{
    BRSettingViewController *settingVC = [[BRSettingViewController alloc] init];
    
    settingVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVC animated:YES];
}



/** 切换夜间模式*/
- (void)night:(UIButton *)nightBtn
{
    nightBtn.selected = !nightBtn.selected;
}

@end
