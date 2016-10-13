//
//  BRNewViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRNewViewController.h"
#import "UIBarButtonItem+BRBarButtonItem.h"
#import "BRSubTagViewController.h"

@implementation BRNewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // ----设置导航栏的样式
    [self setNavBarItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchu) name:BRTabBarBtnRepatClickNotification object:nil];
    
}

- (void)touchu
{
    if (!self.view.window) return;
    
    BRFUNC
}


#pragma mark - 设置导航栏的样式
- (void)setNavBarItem
{
    /** 设置左item*/
    UIBarButtonItem *leftButtonItem        = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagTap)];
    
    self.navigationItem.leftBarButtonItem  = leftButtonItem;
    
    
    
    /** 设置中间titleview*/
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}


#pragma mark - 跳转到标签界面
- (void)tagTap
{
    BRSubTagViewController *subTagVC = [[BRSubTagViewController alloc] init];
    
    [self.navigationController pushViewController:subTagVC animated:YES];
}


@end
