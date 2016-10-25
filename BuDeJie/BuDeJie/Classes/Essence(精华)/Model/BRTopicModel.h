//
//  BRTopicModel.h
//  BuDeJie
//
//  Created by 熊欣 on 16/10/17.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRTopicPersonModel.h"
#import "BRVideoModel.h"
#import "BRGifModel.h"
#import "BRImageModel.h"

@interface BRTopicModel : NSObject

/** 用户的信息*/
@property (nonatomic, readwrite, strong) BRTopicPersonModel *u;

/** 帖子的文字内容*/
@property (nonatomic, readwrite, strong) NSString *text;

/** 帖子审核通过的时间*/
@property (nonatomic, readwrite, strong) NSString *passtime;


/** 顶的数量*/
@property (nonatomic, readwrite, assign) NSInteger up;

/** 踩的数量*/
@property (nonatomic, readwrite, assign) NSInteger down;

/** 转发分享的数量*/
@property (nonatomic, readwrite, assign) NSInteger forward;

/** 评论的数量*/
@property (nonatomic, readwrite, assign) NSInteger comment;

/** 帖子的类型*/
@property (nonatomic, readwrite, strong) NSString *type;

/** 热门评论*/
@property (nonatomic, readwrite, strong) NSArray *top_comments;

/** 视频model*/
@property (nonatomic, readwrite, strong) BRVideoModel *video;

/** GIFmodel*/
@property (nonatomic, readwrite, strong) BRGifModel *gif;

/** 图片的model*/
@property (nonatomic, readwrite, strong) BRImageModel *image;


/** 模型对应的cell的高度，不是服务器返回的*/
@property (nonatomic, readwrite, assign) CGFloat cellHeight;

/** 中间view的frame*/
@property (nonatomic, readwrite, assign) CGRect middleViewFrame;

@end
