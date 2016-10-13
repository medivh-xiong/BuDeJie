//
//  BRTabBar.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/13.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRTabBar.h"

@interface BRTabBar ()

@property (nonatomic, readwrite, strong) UIButton *plusBtn;

/** 上一次被点击的btn*/
@property (nonatomic, readwrite, weak) UIControl *preTabBarBtn;

@end


@implementation BRTabBar


#pragma mark - 懒加载
- (UIButton *)plusBtn
{
    if (!_plusBtn) {
        
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [_plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [_plusBtn sizeToFit];
        
        [self addSubview:_plusBtn];
        
    }
    
    return _plusBtn;
}



/** 添加tabbar中间的按钮*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    NSInteger count     = self.items.count + 1;

    CGFloat width       = self.width / count;

    CGFloat height      = self.height;

    NSInteger index     = 0;
    
    
    for (UIControl *itemView in self.subviews) {
        
        if ([itemView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            /** layout这个方法可能调用多次，因此要做多个判断*/
            if (index == 0 && !self.preTabBarBtn) self.preTabBarBtn = itemView;
            
            if (index == 2) {
                index += 1;
            }
            
            itemView.frame = CGRectMake(index * width, 0, width, height);
            
            index ++;
    
            
            [itemView addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    self.plusBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
}



- (void)tabBarBtnClick:(UIControl *)tabBarBtn
{
    if (self.preTabBarBtn == tabBarBtn) {
       [[NSNotificationCenter defaultCenter] postNotificationName:BRTabBarBtnRepatClickNotification object:nil];
    }
    
    self.preTabBarBtn = tabBarBtn;
 
}


@end
