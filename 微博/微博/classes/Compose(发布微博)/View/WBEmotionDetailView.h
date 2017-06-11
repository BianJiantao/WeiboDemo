//
//  WBEmotionDetailView.h
//  微博
//
//  Created by BJT on 17/5/31.
//  Copyright © 2017年 BJT. All rights reserved.
// 点击表情后 , 显示表情放大图片

#import <UIKit/UIKit.h>

@class WBEmotionButton;
@interface WBEmotionDetailView : UIImageView

/**
 *  从点击表情按钮处,弹出表情细节视图
 *
 *  @param btn 点击的表情按钮
 */
-(void)showFrom:(WBEmotionButton *)btn;

@end
