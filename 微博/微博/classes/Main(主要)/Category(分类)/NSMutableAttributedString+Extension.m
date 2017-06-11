//
//  NSMutableAttributedString+Extension.m
//  微博
//
//  Created by BJT on 17/6/2.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)

+(instancetype)mutableAttributedStringWithAttachment:(NSTextAttachment *)attach
{
    
    return [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
    
}

@end
