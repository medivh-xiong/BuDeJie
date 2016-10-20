//
//  BRTopicModel.h
//  BuDeJie
//
//  Created by 熊欣 on 16/10/17.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRTopicModel : NSObject

/** 用户的名字*/
@property (nonatomic, readwrite, strong) NSString *name;

/** 用户的头像*/
@property (nonatomic, readwrite, strong) NSString *profile_image;

/** 帖子的文字内容*/
@property (nonatomic, readwrite, strong) NSString *text;

/** 帖子审核通过的时间*/
@property (nonatomic, readwrite, strong) NSString *passtime;


/** 顶的数量*/
@property (nonatomic, readwrite, assign) NSInteger ding;

/** 踩的数量*/
@property (nonatomic, readwrite, assign) NSInteger cai;

/** 转发分享的数量*/
@property (nonatomic, readwrite, assign) NSInteger repost;

/** 评论的数量*/
@property (nonatomic, readwrite, assign) NSInteger comment;


@end
