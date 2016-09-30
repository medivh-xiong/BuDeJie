//
//  BRFileTools.h
//  BuDeJie
//
//  Created by 熊欣 on 16/9/30.
//  Copyright © 2016年 熊欣. All rights reserved.
//  缓存管理

#import <Foundation/Foundation.h>

@interface BRFileTools : NSObject


/*!
 *  @author 熊欣, 16-09-30 16:09:11
 *
 *  @brief 异步计算文件夹尺寸并返回
 *
 *  @param cachePath  文件夹路径
 *  @param completion 计算完成后把尺寸回调
 */
+ (void)getCacheSize:(NSString *)cachePath compleion:(void(^)(NSUInteger))completion;



/*!
 *  @author 熊欣, 16-09-30 17:09:53
 *
 *  @brief 删除文件夹
 *
 *  @param directory  文件夹的路劲
 *  @param completion 删除后回到主线程
 */
+ (void)removeCacheAtDirectory:(NSString *)directory compleion:(void(^)())completion;



/*!
 *  @author 熊欣, 16-09-30 16:09:04
 *
 *  @brief 把尺寸转成KB,MB模式，默认不显示B
 *
 *  @param cacheSize 尺寸
 *
 *  @return 转化后的字符串
 */
+ (NSString *)getCacheSizeStr:(NSUInteger)cacheSize;


@end
