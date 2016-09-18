//
//  BRNavigationController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/14.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRNavigationController.h"


@interface BRNavigationController()<UIGestureRecognizerDelegate>

@end




@implementation BRNavigationController


+ (void)load
{
    UINavigationBar *bar       = [UINavigationBar appearanceWhenContainedIn:self, nil];

    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];


    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];

    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];

    [bar setTitleTextAttributes:attrs];

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ----设定滑动返回的手势代理
    self.interactivePopGestureRecognizer.delegate = self;
    
    // ----添加全屏滑动
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//#pragma clang diagnostic pop
// 
//
//    [self.view addGestureRecognizer:pan];
//
//    pan.delegate                = self;
}



#pragma mark - 设定滑动返回的代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}



/** 重写push方法，添加共用返回按钮*/
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        
        UIButton *backBtn = ({
        
            UIButton *btn         = [UIButton buttonWithType:UIButtonTypeCustom];

            [btn setTitle:@"返回" forState:UIControlStateNormal];

            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

            [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];

            [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];

            [btn sizeToFit];

            btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);

            [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            
            btn;
            
        });
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
    }
    
    [super pushViewController:viewController animated:animated];
}



/** 返回上级菜单（出栈）*/
- (void)back
{
    [self popViewControllerAnimated:YES];
}



@end
