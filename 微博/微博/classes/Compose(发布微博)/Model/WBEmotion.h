//
//  WBEmotion.h
//  微博
//
//  Created by BJT on 17/5/29.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBEmotion : NSObject <NSCoding>

/**
 *  表情描述
 */
@property (nonatomic,copy) NSString *chs;
/**
 *  表情 png 图片名
 */
@property (nonatomic,copy) NSString *png;
/**
 *  emoji 十六进制码
 */
@property (nonatomic,copy) NSString *code;

@end
