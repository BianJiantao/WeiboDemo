//
//  WBEmotionTool.h
//  微博
//
//  Created by BJT on 17/6/2.
//  Copyright © 2017年 BJT. All rights reserved.
// 表情存取工具类

#import <Foundation/Foundation.h>

@class WBEmotion;
@interface WBEmotionTool : NSObject

/**
 *  添加一个表情到 最近 表情数组
 */
+(void)addEmotion:(WBEmotion *)emotion;

/**
 *  读取 最近 表情数组
 */
+(NSArray *)recentEmotions;
/**
 *  读取 默认 表情数组
 */
+(NSArray *)defaultEmotions;
/**
*  读取 emoji 表情数组
*/
+(NSArray *)emojiEmotions;
/**
 *  读取 浪小花 表情数组
 */
+(NSArray *)lxhEmotions;


/**
 *  根据一个表情描述,获取对应表情模型
 */
+(WBEmotion *)emotionWithChs:(NSString *)chs;

@end
