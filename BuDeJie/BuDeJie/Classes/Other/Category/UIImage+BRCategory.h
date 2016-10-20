//
//  UIImage+BRCategory.h
//  BuDeJie
//
//  Created by 熊欣 on 16/9/20.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BRCategory)


/*!
 *  @author 熊欣, 16-09-20 17:09:42
 *
 *  @brief 通过给的图片和弧度，制作一个圆角的图片
 *
 *  @param radius 圆角弧度
 *  @param image  初始图片
 *
 *  @return 圆角图片
 */
+ (UIImage *)imageWithCornerRadius:(CGFloat)radius image:(UIImage *)image;


+ (UIImage *)imageWithCircle:(UIImage *)image;

@end
