//
//  WBHttpTool.h
//  微博
//
//  Created by BJT on 17/6/4.
//  Copyright © 2017年 BJT. All rights reserved.
// 网络请求工具类 ( 减小网络请求第三方框架对项目的污染 )

#import <Foundation/Foundation.h>

@interface WBHttpTool : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)urlStr parameters:(id)paras success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


/**
 *  发送POST请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)urlStr parameters:(id)paras success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  上传请求 (上传图片)
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param image   上传的图片
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)urlStr parameters:(id)paras image:(UIImage *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


@end
