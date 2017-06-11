//
//  WBStatusSpecialText.h
//  微博
//
//  Created by BJT on 17/6/6.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博特殊文本模型 ( @,话题, URL )

#import <Foundation/Foundation.h>

@interface WBStatusSpecialText : NSObject

/** 特殊文本模型数组key */
#define kWBStatusSpecialTextKey @"specials"

/**
 *  文本内容
 */
@property (nonatomic,copy) NSString *text;
/**
 *  文本在微博正文整体中的范围
 */
@property (nonatomic,assign) NSRange range;
/**
 *  文本在微博正文整体中的矩形框 ( 可能遇到换行,所以可能有多个矩形框,存储 CGRect )
 */
@property (nonatomic,strong) NSArray *rects;

@end
