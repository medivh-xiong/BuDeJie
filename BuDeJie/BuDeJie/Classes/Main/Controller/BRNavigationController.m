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
    
    
    /** 给导航栏设置公有的进度条*/
    [self setProgressView];
    
    // ----设定滑动返回的手势代理
//    self.interactivePopGestureRecognizer.delegate = self;
    
    // ----添加全屏滑动
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
 

    [self.view addGestureRecognizer:pan];

    pan.delegate                = self;
}



#pragma mark - 设定公有的进度条
- (void)setProgressView
{
    self.loadProgress                   = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 40, BRSCREEN_WIDTH, 1.0f)];

    self.loadProgress.progressTintColor = [UIColor redColor];

    self.loadProgress.trackTintColor    = [UIColor clearColor];

    self.loadProgress.hidden            = YES;
    
    [self.navigationBar addSubview:self.loadProgress];
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
        
        // ----去掉下方的tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [self createBackBtn];
        
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
    }
    
    [super pushViewController:viewController animated:animated];
}


- (UIButton *)createBackBtn
{
    UIButton *backBtn = ({
        
        UIButton *btn         = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [btn sizeToFit];
        
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        
        btn;
        
    });
    
    return backBtn;
}



/** 返回上级菜单（出栈）*/
- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
