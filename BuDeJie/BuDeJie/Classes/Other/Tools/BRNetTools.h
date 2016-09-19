//
//  BRNetTools.h
//  BuDeJie
//
//  Created by 熊欣 on 16/9/19.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>

@interface BRNetTools : AFHTTPSessionManager


/** 请求方法的枚举*/
typedef NS_ENUM(NSUInteger, BRRequsetType) {
    RequsetGET = 0,
    RequestPOST,
};


/** 返回网络工具类的实例*/
+ (instancetype)sharedNetTools;


/*!
 *  @author 熊欣, 16-09-19 10:09:47
 *
 *  @brief 网络请求不带progress
 *
 *  @param BRType     请求的类型
 *  @param urlString  请求的地址
 *  @param parameters 请求的参数
 *  @param success    成功的回调
 *  @param failue     失败的回调
 *
 *  @return 返回NSURLSessionDataTask方便取消请求
 */
- (NSURLSessionDataTask *)httpRequest:(BRRequsetType)BRType
                            urlString:(NSString *)urlString
                           parameters:(id)parameters
                              success:(void (^)(id responseObject))success
                               failue:(void (^) (NSError *error))failue;



/*!
 *  @author 熊欣, 16-09-19 10:09:47
 *
 *  @brief 网络请求带progress进度
 *
 *  @param BRType     请求的类型
 *  @param urlString  请求的地址
 *  @param parameters 请求的参数
 *  @param progress   请求的进度回调
 *  @param success    成功的回调
 *  @param failue     失败的回调
 *
 *  @return 返回NSURLSessionDataTask方便取消请求
 */
- (NSURLSessionDataTask *)httpRequest:(BRRequsetType)BRType
                            urlString:(NSString *)urlString
                           parameters:(id)parameters
                             progress:(void (^)(NSProgress *))downloadProgress
                              success:(void (^)(id responseObject))success
                               failue:(void (^) (NSError *error))failue;





@end
