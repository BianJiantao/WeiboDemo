//
//  NSString+Emoji.h
//  微博
//
//  Created by BJT on 17/5/14.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)
/**
 *  将十六进制的编码转为emoji字符   0x1f603
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符    @"0x1f603"
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
/**
 *  将十六进制的编码转为emoji字符    @"0x1f603"
 */
- (NSString *)emoji;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;
@end
