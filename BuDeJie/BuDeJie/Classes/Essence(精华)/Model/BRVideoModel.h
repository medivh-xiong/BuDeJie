//
//  BRVideoModel.h
//  BuDeJie
//
//  Created by 熊欣 on 16/10/24.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRVideoModel : NSObject

@property (nonatomic, readwrite, assign) CGFloat height;

@property (nonatomic, readwrite, assign) CGFloat width;

@property (nonatomic, readwrite, assign) NSInteger playcount;

@property (nonatomic, readwrite, assign) CGFloat duration;

/** 大图*/
@property (nonatomic, readwrite, strong) NSArray *thumbnail;

/** 小图*/
@property (nonatomic, readwrite, strong) NSArray *thumbnail_small;

/** 视频*/
@property (nonatomic, readwrite, strong) NSArray *video;

@end
