//
//  WBHttpTool.m
//  微博
//
//  Created by BJT on 17/6/4.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBHttpTool.h"
#import "AFNetworking.h"

@implementation WBHttpTool

+(void)GET:(NSString *)urlStr parameters:(id)paras success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:urlStr parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}

+(void)POST:(NSString *)urlStr parameters:(id)paras success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:urlStr parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}


+ (void)POST:(NSString *)urlStr parameters:(id)paras image:(UIImage *)image success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
     AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:urlStr parameters:paras constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData:imageData name:@"pic" fileName:@"test.jpeg" mimeType:@"image/jpeg"];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}


@end
