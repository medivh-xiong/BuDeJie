//
//  BRShareBtn.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/26.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRShareBtn.h"

@implementation BRShareBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    // ----设置图片的位置
    self.imageView.y        = 0;

    self.imageView.centerX  = self.width * 0.5;


    // ----设置标题栏的位置
    self.titleLabel.y       = self.height - self.titleLabel.height;
    
    [self.titleLabel sizeToFit];
    
    self.titleLabel.centerX = self.width * 0.5;

}

@end
