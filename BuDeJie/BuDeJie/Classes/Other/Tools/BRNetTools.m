//
//  BRNetTools.m
//  BuDeJie
//
//  Created by 熊欣 on 16/9/19.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "BRNetTools.h"

@implementation BRNetTools


static BRNetTools *sharedTools = nil;

+ (instancetype)sharedNetTools
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTools = [self manager];
    });
    
    return sharedTools;
}



- (NSURLSessionDataTask *)httpRequest:(BRRequsetType)BRType urlString:(NSString *)urlString parameters:(id)parameters success:(void (^)(id responseObject))success failue:(void (^) (NSError *error))failue
{
    return  [self httpRequest:BRType urlString:urlString parameters:parameters progress:nil success:success failue:failue];
}



- (NSURLSessionDataTask *)httpRequest:(BRRequsetType)BRType urlString:(NSString *)urlString parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(id responseObject))success failue:(void (^) (NSError *error))failue
{
    NSURLSessionDataTask *task;
    
    
    if (BRType == RequsetGET) {
        
        task = [self GET:urlString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failue) {
                failue(error);
            }
            
        }];

    }else {
        
        task = [self POST:urlString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failue) {
                failue(error);
            }
        
        }];
        
    }
    
    
    return task;
    
}





@end
