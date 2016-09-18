//
//  BRNewViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRNewViewController.h"
#import "UIBarButtonItem+BRBarButtonItem.h"

@implementation BRNewViewController


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
    UIBarButtonItem *leftButtonItem        = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(touchu)];
    
    self.navigationItem.leftBarButtonItem  = leftButtonItem;
    
    
    
    /** 设置中间titleview*/
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}


- (void)touchu {
	
}


@end
