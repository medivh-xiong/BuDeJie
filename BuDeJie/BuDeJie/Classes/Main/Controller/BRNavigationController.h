//
//  BRNavigationController.h
//  BuDeJie
//
//  Created by 熊欣 on 16/9/14.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRNavigationController : UINavigationController

@property (nonatomic, readwrite, strong) UIProgressView *loadProgress;


/** 创建一个返回按钮*/
- (UIButton *)createBackBtn;

@end
