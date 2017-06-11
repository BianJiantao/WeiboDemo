//
//  WBStatusTextView.h
//  微博
//
//  Created by BJT on 17/6/6.
//  Copyright © 2017年 BJT. All rights reserved.
// 显示微博正文( 便于监听微博特殊文本的点击 )

#import <Foundation/Foundation.h>

@interface WBStatusTextView : UITextView

/**
 *  每一条微博中的特殊文本模型 ( WBStatusSpecialText )
 */
@property (nonatomic,strong) NSArray *specials;

@end
