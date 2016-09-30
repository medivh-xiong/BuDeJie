//
//  BRLoginRegisterViewController.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/21.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRLoginRegisterViewController.h"
#import "BRLoginRegisterView.h"
#import "BRShareBtnView.h"

@interface BRLoginRegisterViewController ()

/** 中间占位视图*/
@property (weak, nonatomic) IBOutlet UIView *middleView;

/** 底部占位视图*/
@property (weak, nonatomic) IBOutlet UIView *bottomView;

/** 切换登陆和注册界面的按钮*/
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

/** 中间视图的左边约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConstant;

@property (nonatomic, readwrite, assign) BOOL first;

@end

@implementation BRLoginRegisterViewController


#pragma mark -设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



#pragma mark - 视图加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ----加载UI
    [self setUpUI];
    
}



#pragma mark - 加载UI
- (void)setUpUI
{
    // ----1.添加登陆界面
    BRLoginRegisterView *loginView    = [BRLoginRegisterView loadLoginView];

    [self.middleView addSubview:loginView];


    // ----2.添加注册界面
    BRLoginRegisterView *registerView = [BRLoginRegisterView loadRegisterView];

    [self.middleView addSubview:registerView];

    // ----3.添加分享界面
    BRShareBtnView *shareBtnView      = [BRShareBtnView shareBtnView];

    [self.bottomView addSubview:shareBtnView];
    
    
    // ----设定是第一次打开
    self.first = YES;
    
    // ----如果是注册界面打开，设置切换登陆和注册界面的按钮的选择状态
    self.loginRegisterBtn.selected = !self.isLogin;
}



#pragma mark - 更新布局
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // ----更新登陆界面和注册界面的布局
    BRLoginRegisterView *loginView    = self.middleView.subviews[0];

    loginView.frame                   = CGRectMake(0, 0, self.middleView.width * 0.5, self.middleView.height);


    BRLoginRegisterView *registerView = self.middleView.subviews[1];

    registerView.frame                = CGRectMake(self.middleView.width * 0.5, 0, self.middleView.width * 0.5, self.middleView.height);



    // ----更新分享界面的View
    BRShareBtnView *shareView         = self.bottomView.subviews[0];

    shareView.frame                   = self.bottomView.bounds;
    
    
    
    // ----判断是否是第一进来，否则会影响布局
    if (self.first) {
        
         self.leadConstant.constant = !self.isLogin ? -self.middleView.width * 0.5 : 0;
       
        self.first = NO;
    }

}



#pragma mark - 按钮的点击事件
// ----关闭登陆注册界面
- (IBAction)closeVC:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



// ----切换登陆界面和注册界面
- (IBAction)clickRegister:(UIButton *)btn
{
    /** 先关闭键盘*/
    [self.view endEditing:YES];
    
    btn.selected               = !btn.selected;
    
    self.leadConstant.constant = btn.selected ? -self.middleView.width * 0.5 : 0;
    
    [UIView animateWithDuration:0.4 animations:^{
        // ----做布局需要调用
        [self.view layoutIfNeeded];
    }];
}



#pragma mark - 处理键盘的关闭
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
