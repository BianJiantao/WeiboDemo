//
//  WBEmotionButton.h
//  微博
//
//  Created by BJT on 17/6/1.
//  Copyright © 2017年 BJT. All rights reserved.
// 表情按钮 (一个表情按钮对应一个表情模型)

#import <UIKit/UIKit.h>


@class WBEmotion;
@interface WBEmotionButton : UIButton

/**
 *  emotion 模型
 */
@property (nonatomic,strong) WBEmotion *emotion;

@end
