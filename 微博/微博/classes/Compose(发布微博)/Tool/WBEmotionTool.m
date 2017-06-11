//
//  WBEmotionTool.m
//  微博
//
//  Created by BJT on 17/6/2.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "MJExtension.h"

#import "WBEmotionTool.h"
#import "WBEmotion.h"

#define kEmotionSavePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotions.archive"]


@implementation WBEmotionTool
// 静态内部全局变量, 防止频繁的 读文件 获取表情数组 操作
static NSMutableArray *_recentEmotions ;
static NSArray *_defaultEmotions,*_emojiEmotions,*_lxhEmotions;

+(void)initialize
{
    // 防止频繁的读文件取操作
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:kEmotionSavePath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

+(WBEmotion *)emotionWithChs:(NSString *)chs
{
    NSArray *defaultEmotions = [self defaultEmotions];
    for (WBEmotion *emotion in defaultEmotions) {
        if ([emotion.chs isEqualToString:chs]) { // 默认 表情
            return emotion;
        }
    }
    NSArray *lxhEmotions = [self lxhEmotions];
    for (WBEmotion *emotion in lxhEmotions) {
        if ([emotion.chs isEqualToString:chs]) { // 浪小花 表情
            return emotion;
        }
    }
    
    return nil; // 本地未找到对应表情
}


/**
 *  添加一个表情
 */
+(void)addEmotion:(WBEmotion *)emotion
{
    // 法1. 创建一个临时数组进行遍历
//    NSMutableArray *tempArr = [arrayM mutableCopy];
//    for (WBEmotion *em in tempArr) {
//        if ([em.chs isEqualToString:emotion.chs] || [em.code isEqualToString:emotion.code] ) {
//            [arrayM removeObject:em];
//            break;
//        }
//    }
    // 法2. 系统会调用 emotion 的 isEqual: 方法,对该方法进行重写即可
    [_recentEmotions removeObject:emotion];
    
 
    [_recentEmotions insertObject:emotion atIndex:0];
    
//    WBLog(@"arrayM%@",arrayM);
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:kEmotionSavePath];
    
}

/**
 *  读取 最近 表情数组
 */
+(NSArray *)recentEmotions
{
     return _recentEmotions;
}

/**
 *  读取 默认 表情数组
 */
+(NSArray *)defaultEmotions
{
    if (_defaultEmotions == nil) {
        
        NSString  *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        _defaultEmotions = [WBEmotion objectArrayWithKeyValuesArray:dictArray];
    }
    
    return _defaultEmotions;
}

/**
 *  读取 emoji 表情数组
 */
+(NSArray *)emojiEmotions
{
    if (_emojiEmotions == nil) {
        
        NSString  *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        _emojiEmotions = [WBEmotion objectArrayWithKeyValuesArray:dictArray];
    }
    
    return _emojiEmotions;
}

/**
 *  读取 浪小花 表情数组
 */
+(NSArray *)lxhEmotions
{    
    if (_lxhEmotions == nil) {
        
        NSString  *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        _lxhEmotions = [WBEmotion objectArrayWithKeyValuesArray:dictArray];
    }
    
    return _lxhEmotions;
}



@end
