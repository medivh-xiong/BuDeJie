//
//  UIImageView+BRWebImage.h
//  BuDeJie
//
//  Created by 熊欣 on 16/10/25.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BRWebImage)


/*!
 *  @author 熊欣, 16-10-25 15:10:44
 *
 *  @brief 根据不同的网络状况设置不同的图片
 *
 *  @param originImageUrl    原图的地址
 *  @param thumbnailImageUrl 缩略图的地址
 *  @param placeHolderImage  占位图
 */
- (void)BRSetOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeHolder:(UIImage *)placeHolderImage;




/*!
 *  @author 熊欣, 16-10-25 16:10:35
 *
 *  @brief 设置头像照片，这里默认是圆形图片，同时设置刷新机制，如果头像更新后，图片会重新下载
 *
 *  @param headerURL   图像地址
 *  @param placeHolder 占位图
 */
- (void)BRSetHeaderImage:(NSString *)headerURL placeHolder:(UIImage *)placeHolderImage;


@end
