//
//  BRLoginRegisterViewController.h
//  BuDeJie
//
//  Created by 熊欣 on 16/9/21.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRBaseViewController.h"

@interface BRLoginRegisterViewController : BRBaseViewController

/** 判断是登陆界面进来还是注册界面进来*/
@property (nonatomic, getter=isLogin, assign) BOOL login;

@end
