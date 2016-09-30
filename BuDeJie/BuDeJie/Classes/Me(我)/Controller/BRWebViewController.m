//
//  BRWebViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/28.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRWebViewController.h"
#import <WebKit/WebKit.h>
#import "BRNavigationController.h"

@interface BRWebViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, readwrite, weak) WKWebView *webView;

@property (nonatomic, readwrite, strong) BRNavigationController *baseNav;

@end

@implementation BRWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ----设定初始的title
    self.title = @"百思不得姐";
    
    // ----添加wkwebview
    [self setWebView];
    
   
    // ----添加webview的KVO
    [self setWebViewKVO];
    
}



#pragma mark - 添加webView
- (void)setWebView
{
    WKWebView *web = [[WKWebView alloc] init];
    
    self.webView   = web;
    
    NSURLRequest *requeset = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [web loadRequest:requeset];
    
    
    [self.contentView addSubview:web];
    
    
}



#pragma mark - 对webview的布局
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = self.contentView.bounds;
}



#pragma mark - 添加对webView的监听
- (void)setWebViewKVO
{
    // ----添加对标题栏的监听
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    // ----添加对进度条的监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    // ----添加对网页后退的监听
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
}



#pragma mark - KVO处理的事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    // ----1.先获取自定义导航栏
    _baseNav = (BRNavigationController *)self.navigationController;

    _baseNav.loadProgress.hidden     = NO;

    // ----2.然后设置对应的属性
    _baseNav.loadProgress.progress   = self.webView.estimatedProgress;
    
    if (_baseNav.loadProgress.progress >= 0.4) {
        
        // ----如果获得到的网页标题栏为空，则不赋值
        if (![self.webView.title isEqualToString:@""]) {
            self.title = self.webView.title;
        }
    
        // ----如果进度条到头，就把它隐藏
        if (_baseNav.loadProgress.progress >= 1.0) {
            _baseNav.loadProgress.hidden = YES;
        }
    }
    
    
    // ----设置返回的item
    UIBarButtonItem *backItem = ({
        
        UIButton *backBtn         = [_baseNav createBackBtn];

        [backBtn addTarget:self action:@selector(webViewBack) forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];

        backItem;
    
    });
    
    
    // ----设置关闭的按钮
    UIButton *closeBtn = ({
        
        UIButton *closeBtn       = [UIButton buttonWithType:UIButtonTypeCustom];

        [UIButton buttonWithType:UIButtonTypeCustom];

        [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [closeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 8)];

        closeBtn.titleLabel.font = [UIFont systemFontOfSize:16];

        [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];

        closeBtn.frame           = CGRectMake(0, 0, 33, 33);

        [closeBtn addTarget:self action:@selector(closeWeb) forControlEvents:UIControlEventTouchUpInside];
        
        closeBtn;
    
    });

    
    // ----设置关闭按钮的item
    UIBarButtonItem *closeItem = ({
        [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    });
    
    
    // ----判断何时显示何时隐藏关闭的btn
    if (self.webView.canGoBack) {
         self.navigationItem.leftBarButtonItems = @[backItem, closeItem];
    }else {
        self.navigationItem.leftBarButtonItems = @[backItem];
    }
    
}


// ----返回按钮的时间
- (void)webViewBack
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else {
        
        _baseNav.loadProgress.hidden = YES;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


// ----关闭按钮的事件
- (void)closeWeb
{
   _baseNav.loadProgress.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 移除KVO
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"title"];
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
}




@end
