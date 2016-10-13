//
//  BRAdDataModel.h
//  BuDeJie
//
//  Created by 熊欣 on 16/9/18.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BRAdDataModel : NSObject

/** 广告的图片*/
@property (nonatomic, readwrite, strong) NSString *w_picurl;

/** 点击广告跳转的网址*/
@property (nonatomic, readwrite, strong) NSString *ori_curl;

/** 广告的宽度*/
@property (nonatomic, readwrite, assign) CGFloat  w;

/** 广告的高度*/
@property (nonatomic, readwrite, assign) CGFloat  h;


@end
