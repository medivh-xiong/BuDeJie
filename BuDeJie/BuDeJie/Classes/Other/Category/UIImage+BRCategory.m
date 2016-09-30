//
//  UIImage+BRCategory.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/20.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "UIImage+BRCategory.h"

@implementation UIImage (BRCategory)


+ (UIImage *)imageWithCornerRadius:(CGFloat)radius image:(UIImage *)image
{
    // ----1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // ----2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:16.0f];
    
    // ----3.设置裁剪区域
    [path addClip];
    
    // ----4.画图
    [image drawAtPoint:CGPointZero];
    
    // ----5.取出图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // ----6.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}


@end
