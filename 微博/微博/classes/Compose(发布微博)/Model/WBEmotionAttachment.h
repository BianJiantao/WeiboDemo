//
//  WBEmotionAttachment.h
//  微博
//
//  Created by BJT on 17/6/2.
//  Copyright © 2017年 BJT. All rights reserved.
// 带表情模型的附件

#import <UIKit/UIKit.h>

@class WBEmotion;
@interface WBEmotionAttachment : NSTextAttachment

/**
 *  表情模型
 */
@property (nonatomic,strong) WBEmotion *emotion;

@end
