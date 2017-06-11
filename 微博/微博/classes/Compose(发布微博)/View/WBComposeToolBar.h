//
//  WBComposeToolBar.h
//  微博
//
//  Created by BJT on 17/5/26.
//  Copyright © 2017年 BJT. All rights reserved.
// 发微博页面键盘上面的工具条

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WBComposeToolBarBtnType){
    WBComposeToolBarBtnTypeCamera  ,  // Camera
    WBComposeToolBarBtnTypePicture, // photoLiabrary
    WBComposeToolBarBtnTypeMention, // @
    WBComposeToolBarBtnTypeTrend,   // #
    WBComposeToolBarBtnTypeEmotion  //  Emotion emoji
};

@class WBComposeToolBar;
@protocol WBComposeToolBarDelegate <NSObject>
@optional
- (void)composeToolbar:(WBComposeToolBar *)toolbar DidClickBtnType:(WBComposeToolBarBtnType)buttonType;

@end

@interface WBComposeToolBar : UIView

@property (nonatomic,weak) id<WBComposeToolBarDelegate> delegate;

/**
 *  是否显示键盘图片按钮(切换键盘时赋值)
 */
@property (nonatomic,assign) BOOL showKeyboardButton;

@end
