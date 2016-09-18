//
//  UIBarButtonItem+BRBarButtonItem.h
//  BuDeJie
//
//  Created by 熊欣 on 16/9/14.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BRBarButtonItem)


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectedImg:(UIImage *)selectedImg target:(id)target action:(SEL)action;


@end
