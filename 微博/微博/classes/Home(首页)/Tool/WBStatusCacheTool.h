//
//  WBStatusCacheTool.h
//  微博
//
//  Created by BJT on 17/6/9.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博离线缓存工具类

#import <Foundation/Foundation.h>

@interface WBStatusCacheTool : NSObject
/**
 *  保存微博数组(存储的字典)到数据库
 *
 *  @param statuses 字典数组
 */
+(void)saveStatusToCache:(NSArray *)statuses;

/**
 *  从数据库缓存读取微博数据
 *
 *  @return 字典数组
 */
+(NSArray *)statusesFromCacheWithParameters:(NSDictionary *)parameters;

@end
