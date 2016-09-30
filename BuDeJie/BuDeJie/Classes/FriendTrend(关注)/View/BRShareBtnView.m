//
//  BRShareBtnView.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/22.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRShareBtnView.h"

@implementation BRShareBtnView

+ (instancetype)shareBtnView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BRShareBtnView class]) owner:nil options:nil] firstObject];
}

@end
