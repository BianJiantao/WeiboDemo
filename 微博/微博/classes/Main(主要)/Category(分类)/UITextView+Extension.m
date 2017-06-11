//
//  UITextView+Extension.m
//  微博
//
//  Created by BJT on 17/6/2.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

-(void)insertAttributeText:(NSAttributedString *)attributeText
{
    NSRange range = self.selectedRange;
    NSMutableAttributedString * attrStrM = [[NSMutableAttributedString alloc] init];
    
    [attrStrM appendAttributedString:self.attributedText];
    [attrStrM replaceCharactersInRange:range withAttributedString:attributeText];
    //        [attrStrM addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attrStrM.length)];
    self.attributedText = attrStrM;
    // 移动光标到 插入文本 后
    self.selectedRange = NSMakeRange(range.location + 1, 0);
}


@end
