//
//  WBEmotionTextView.h
//  微博
//
//  Created by BJT on 17/6/1.
//  Copyright © 2017年 BJT. All rights reserved.
// 带占位文字,可插入表情的 textView

#import "WBTextView.h"

@class WBEmotion;
@interface WBEmotionTextView : WBTextView

/**
 *  在当前光标处,插入表情
 */
-(void)insertEmotion:(WBEmotion *)emotion;

/**
 *  把表情转换成相应文本,构成一个完整的微博文本内容
 */
-(NSString *)fullText;

@end
