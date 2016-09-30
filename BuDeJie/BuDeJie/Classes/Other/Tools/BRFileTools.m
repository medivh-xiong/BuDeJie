//
//  BRFileTools.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/30.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRFileTools.h"

@implementation BRFileTools


+ (void)getCacheSize:(NSString *)cachePath compleion:(void(^)(NSUInteger))completion
{
    [self judgeFilePath:cachePath];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        NSArray *fileArray     = [fileMgr subpathsAtPath:cachePath];
        
        NSUInteger cacheSize   = 0;
        
        for (NSString *subPath in fileArray) {
            
            NSString *filePath = [cachePath stringByAppendingPathComponent:subPath];
            
            if ([filePath containsString:@".DS"]) continue;
            
            BOOL isDire;
            
            BOOL isExist        = [fileMgr fileExistsAtPath:filePath isDirectory:&isDire];
            
            if (!isExist || isDire) continue;
            
            NSDictionary *attrs = [fileMgr attributesOfItemAtPath:filePath error:nil];
            
            NSUInteger size     = [attrs fileSize];
            
            cacheSize += size;
        }
        
        /** 回到主线程处理UI*/
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (completion) {
                completion(cacheSize);
            }
            
        });
        
    });
    
}



+ (NSString *)getCacheSizeStr:(NSUInteger)cacheSize
{
    CGFloat sizeF;
    
    NSString *sizeStr;
    
    if (cacheSize > 1000 * 1000) {
        
        sizeF   = cacheSize / 1000.0 / 1000.0;
        
        sizeStr = [NSString stringWithFormat:@"%.1fMB", sizeF];
        
    }else if (cacheSize >= 1000) {
        
        sizeF   = cacheSize / 1000.0;
        
        sizeStr = [NSString stringWithFormat:@"%.1fKB", sizeF];
        
    }else if(cacheSize < 1000) {
        sizeStr = @"";
    }
    
    return sizeStr;
    
}



+ (void)removeCacheAtDirectory:(NSString *)directory compleion:(void(^)())completion
{
    [self judgeFilePath:directory];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        NSArray *direArray = [mgr contentsOfDirectoryAtPath:directory error:nil];
        
        for (NSString *direPath in direArray) {
            
            NSString *filePath = [directory stringByAppendingPathComponent:direPath];
            
            [mgr removeItemAtPath:filePath error:nil];
            
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (completion) {
                completion();
            }
            
        });
        
        
        
    });
    

    
}


/** 判断是否是文件夹，不是则抛出异常*/
+ (void)judgeFilePath:(NSString *)filePath
{
    NSFileManager *mgr = [NSFileManager defaultManager];

    BOOL isDire;

    BOOL isExist       = [mgr fileExistsAtPath:filePath isDirectory:&isDire];
    
    if (!isExist || !isDire) {
        
        NSException *exception = [NSException exceptionWithName:@"fileError" reason:@"需要传入的是文件夹路径,并且路径要存在" userInfo:nil];
        
        [exception raise];
        
    }
    
}

@end
