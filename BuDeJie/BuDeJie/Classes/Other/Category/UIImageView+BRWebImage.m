//
//  UIImageView+BRWebImage.m
//  BuDeJie
//
//  Created by 熊欣 on 16/10/25.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "UIImageView+BRWebImage.h"
#import "UIImageView+WebCache.h"
#import "AFNetworkReachabilityManager.h"
#import "SDImageCache.h"
#import "UIImage+BRCategory.h"

@implementation UIImageView (BRWebImage)


- (void)BRSetOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeHolder:(UIImage *)placeHolderImage
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    
    // ----判断是否缓存中是否有高清图,如果有直接设置图片
    if (originImage) {
        // ----SD内部做了处理如果图片存在不会重新下载，同时显示GIF
        [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    }else {
        // ----如果缓存中没有图，判断当前的网络状态,如果是wifi则加载高清图
        if (mgr.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
        }else if(mgr.isReachableViaWWAN) {
            // ----如果是流量环境，就加载缩略图
            [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];;
        }else {
            // ----如果没有网络情境下，如果有缩略图，就加载缩略图
            UIImage *smallImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            
            if (smallImage) {
                self.image = smallImage;
            }else {
                // ----占位图，或者为了防止循环引用，把之前设置的图片清空
                self.image = placeHolderImage;
            }
            
        }
    }
}



- (void)BRSetHeaderImage:(NSString *)headerURL placeHolder:(UIImage *)placeHolderImage
{
    UIImage *ciclePlaceHolder = [UIImage imageWithCircle:placeHolderImage];
    
    self.image = ciclePlaceHolder;
    
    [self sd_setImageWithURL:[NSURL URLWithString:headerURL] placeholderImage:placeHolderImage options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (!image) return;
        
        self.image = [UIImage imageWithCircle:image];
        
    }];
}



@end
