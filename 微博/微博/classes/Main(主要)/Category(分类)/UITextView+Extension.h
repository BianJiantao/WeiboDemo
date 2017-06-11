//
//  UITextView+Extension.h
//  微博
//
//  Created by BJT on 17/6/2.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

/**
 *  在光标选中处,插入带属性文本
 */
-(void)insertAttributeText:(NSAttributedString *)attributeText;

@end
