//
//  UILabel+BRCategory.h
//  BuDeJie
//
//  Created by 熊欣 on 16/10/25.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BRCategory)

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;


@end
