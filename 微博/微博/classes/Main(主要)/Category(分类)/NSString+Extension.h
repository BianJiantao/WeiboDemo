//
//  NSString+Extension.h
//  微博
//
//  Created by BJT on 17/5/22.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  get text size  with text font and max text width
 *
 */
- (CGSize)sizeWithTextFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/**
 *  get text size  with text font
 *
 */
-(CGSize)sizeWithTextFont:(UIFont *)font;
/**
 *  计算当前文件\文件夹的内容大小
 */
-(NSInteger)fileSize;

@end
