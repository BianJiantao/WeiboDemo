//
//  NSMutableAttributedString+Extension.h
//  微博
//
//  Created by BJT on 17/6/2.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableAttributedString (Extension)


/**
 *  用附件创建一个可变属性字符串
 */
+(instancetype)mutableAttributedStringWithAttachment:(NSTextAttachment *)attach;

@end
