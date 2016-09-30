//
//  BRFriendTrendViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRFriendTrendViewController.h"
#import "UIBarButtonItem+BRBarButtonItem.h"
#import "BRLoginRegisterViewController.h"
#import "UITextField+BRTextField.h"

@implementation BRFriendTrendViewController


#pragma mark - 视图加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // ----设置导航栏的样式
    [self setNavBarItem];
}



#pragma mark - 设置导航栏的样式
- (void)setNavBarItem
{
    /** 设置左item*/
    UIBarButtonItem *leftButtonItem        = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(touchu)];
    
    self.navigationItem.leftBarButtonItem  = leftButtonItem;
    
    
    
    /** 设置中间titleview*/
    self.navigationItem.title = @"关注";
    
}


- (void)touchu {
    
}



#pragma mark - 登陆按钮点击
- (IBAction)loginClick:(id)sender
{
    BRLoginRegisterViewController *loginVC = [[BRLoginRegisterViewController alloc] init];

    loginVC.login                          = YES;
    
    [self presentViewController:loginVC animated:YES completion:nil];
}



#pragma mark - 注册按钮点击
- (IBAction)registerClick:(id)sender
{
    
    BRLoginRegisterViewController *loginVC = [[BRLoginRegisterViewController alloc] init];

    loginVC.login                          = NO;
    
    [self presentViewController:loginVC animated:YES completion:nil];
    
}


@end
