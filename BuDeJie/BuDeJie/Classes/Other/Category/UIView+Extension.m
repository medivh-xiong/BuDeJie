//
//  UIView+Extension.m
//  Bluei
//
//  Created by 熊欣 on 15/12/4.
//  Copyright © 2015年 熊欣. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)


- (void)setX:(CGFloat)x
{
    CGRect frame   = self.frame;
    frame.origin.x = x;
    self.frame     = frame;
}



- (void)setY:(CGFloat)y
{
    CGRect frame   = self.frame;
    frame.origin.y = y;
    self.frame     = frame;
}



- (CGFloat)x
{
    return self.frame.origin.x;
}



- (CGFloat)y
{
    return self.frame.origin.y;
}



- (void)setWidth:(CGFloat)width
{
    CGRect frame     = self.frame;
    frame.size.width = width;
    self.frame       = frame;
}



- (void)setHeight:(CGFloat)height
{
    CGRect frame      = self.frame;
    frame.size.height = height;
    self.frame        = frame;
}



- (CGFloat)width
{
    return self.frame.size.width;
}



- (CGFloat)height
{
    return self.frame.size.height;
}



- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x       = centerX;
    self.center    = center;
}



- (CGFloat)centerX
{
    return self.center.x;
}



- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y       = centerY;
    self.center    = center;
}



- (CGFloat)centerY
{
    return self.center.y;
}



- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size   = size;
    self.frame   = frame;
}



- (CGSize)size
{
    return self.frame.size;
}



- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame   = frame;
}



- (CGPoint)origin
{
    return self.frame.origin;
}


/** 加载xib内容*/
+ (instancetype)viewWithNib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


- (NSString *)timeFormatted:(NSInteger)totalSeconds
{
    
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours   = totalSeconds / 3600;
    
    if (hours != 0) {
        return [NSString stringWithFormat:@"%02li:%02li:%02li",hours, minutes, seconds]; 
    }else {
        return [NSString stringWithFormat:@"%02li:%02li", minutes, seconds];
    }
   
}


@end
