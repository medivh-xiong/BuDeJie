//
//  BREssenceViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BREssenceViewController.h"
#import "UIBarButtonItem+BRBarButtonItem.h"


@interface BREssenceViewController()


@end

@implementation BREssenceViewController


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
    UIBarButtonItem *leftButtonItem        = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(touchu)];

    self.navigationItem.leftBarButtonItem  = leftButtonItem;

    
    
    /** 设置右item*/
    UIBarButtonItem *randomBtnItem         = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
    self.navigationItem.rightBarButtonItem = randomBtnItem;
    
    
    
    /** 设置中间titleview*/
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

}



- (void)touchu
{
  
}

- (void)random {
    
}







@end
