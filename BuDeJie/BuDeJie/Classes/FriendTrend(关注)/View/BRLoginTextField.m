//
//  BRLoginTextField.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/26.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRLoginTextField.h"
#import "UITextField+BRTextField.h"

@implementation BRLoginTextField


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    /** 设定初始的颜色*/
    self.placeholderColor = [UIColor lightGrayColor];

    [self addTarget:self action:@selector(textEditBegin) forControlEvents:UIControlEventEditingDidBegin];

    [self addTarget:self action:@selector(textEditEnd) forControlEvents:UIControlEventEditingDidEnd];
}



- (void)textEditBegin
{
    self.placeholderColor = [UIColor whiteColor];
}



- (void)textEditEnd
{
    self.placeholderColor = [UIColor lightGrayColor];
}


@end
