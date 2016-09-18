//
//  UIBarButtonItem+BRBarButtonItem.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/14.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "UIBarButtonItem+BRBarButtonItem.h"

@implementation UIBarButtonItem (BRBarButtonItem)


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn         = [UIButton buttonWithType:UIButtonTypeCustom];

    [btn setImage:image forState:UIControlStateNormal];

    [btn setImage:highImage forState:UIControlStateHighlighted];

    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}



+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectedImg:(UIImage *)selectedImg target:(id)target action:(SEL)action
{
    UIButton *btn         = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setImage:selectedImg forState:UIControlStateSelected];
    
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}





@end
