//
//  WBTextView.h
//  微博
//
//  Created by BJT on 17/5/25.
//  Copyright © 2017年 BJT. All rights reserved.
//  带占位文字的 textView (增强版 UITextView)
// textView with placeHolder text ( Enhanced UITextView )

//#define WBNotificationCenter [NSNotificationCenter defaultCenter]


#import <UIKit/UIKit.h>


@interface WBTextView : UITextView

/**
 *  占位文本 placeHolder Text
 */
@property (nonatomic,copy) NSString *placeHolderText;
/**
 *  占位文字颜色 placeHolder Text Color
 */
@property (nonatomic,strong) UIColor *placeHolderColor;

@end
