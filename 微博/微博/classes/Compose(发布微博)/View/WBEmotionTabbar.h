//
//  WBEmotionTabbar.h
//  微博
//
//  Created by BJT on 17/5/29.
//  Copyright © 2017年 BJT. All rights reserved.
// 表情键盘底部工具条

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WBEmotionTabbarButtonType){
    WBEmotionTabbarButtonTypeRecent ,  // 最近
    WBEmotionTabbarButtonTypeDefult, // 默认
    WBEmotionTabbarButtonTypeEmoji, // emoji
    WBEmotionTabbarButtonTypeLxh  //  浪小花
};

@class WBEmotionTabbar;
@protocol WBEmotionTabbarDelegate <NSObject>

@optional
/**
 *  emotionTabbar 代理方法
 */
- (void)emotionTabbar:(WBEmotionTabbar *)tabbar didClickButton:(WBEmotionTabbarButtonType)buttonType;

@end

@interface WBEmotionTabbar : UIView
/**
 *  按钮点击代理
 */
@property (nonatomic,weak) id<WBEmotionTabbarDelegate> delegate;

@end
