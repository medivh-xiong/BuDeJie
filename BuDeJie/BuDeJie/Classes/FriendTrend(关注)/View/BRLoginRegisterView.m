//
//  BRLoginRegisterView.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/22.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRLoginRegisterView.h"

@implementation BRLoginRegisterView


/** 加载登陆界面*/
+ (instancetype)loadLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BRLoginRegisterView class]) owner:nil options:nil] firstObject];
}



/** 加载注册界面*/
+ (instancetype)loadRegisterView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BRLoginRegisterView class]) owner:nil options:nil] lastObject];
}


@end
