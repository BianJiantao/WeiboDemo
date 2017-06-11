//
//  WBStatusTextSegment.h
//  微博
//
//  Created by BJT on 17/6/6.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博正文碎片 (由正则表达式拆分)

#import <Foundation/Foundation.h>

@interface WBStatusTextSegment : NSObject

/**
 *  文本碎片内容
 */
@property (nonatomic,copy) NSString *text;
/**
 *  文本碎片范围
 */
@property (nonatomic,assign) NSRange range;
/**
 *  是否是特殊文本碎片
 */
@property (nonatomic,assign,getter=isSpecial) BOOL special;


/**
 *  是否是表情
 */
@property (nonatomic,assign,getter=isEmotion) BOOL emotion;


@end
