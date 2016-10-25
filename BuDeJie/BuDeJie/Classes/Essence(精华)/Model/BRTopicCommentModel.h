//
//  BRTopicCommentModel.h
//  BuDeJie
//
//  Created by 熊欣 on 16/10/21.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRTopicPersonModel.h"

@interface BRTopicCommentModel : NSObject

@property (nonatomic, readwrite, strong) BRTopicPersonModel *u;

@property (nonatomic, readwrite, strong) NSString *content;

@property (nonatomic, readwrite, assign) NSInteger like_count;

/** 这里是热门评论的占据lable的高度*/
@property (nonatomic, readwrite, assign) CGFloat contentHeight;

@end
