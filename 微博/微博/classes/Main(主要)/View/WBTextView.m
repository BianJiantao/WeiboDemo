//
//  WBTextView.m
//  微博
//
//  Created by BJT on 17/5/25.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBTextView.h"

@implementation WBTextView

-(instancetype)init{
    
    if (self = [super init]) {
        self.placeHolderColor = [UIColor lightGrayColor]; // defaul placeHolder Color
        [WBNotificationCenter addObserver:self selector:@selector(textInputDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)dealloc
{
    [WBNotificationCenter removeObserver:self];
}

- (void)drawRect:(CGRect)rect { // 绘制占位文字
    
    if(self.hasText) return; // text did input , don't draw placeHolderText
    
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = self.font;
    attrDict[NSForegroundColorAttributeName] = self.placeHolderColor;
    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat width = self.width -  2 * x;
    CGFloat height = self.height - 2 * y;
    CGRect textRect = CGRectMake(x, y, width, height);
    
    [self.placeHolderText drawInRect:textRect withAttributes:attrDict];

}
/**
 *  文本内容改变
 */
- (void)textInputDidChange
{
    [self setNeedsDisplay]; // refresh UI after text content changed
}

/**
 *  设置占位文字
 */
-(void)setPlaceHolderText:(NSString *)placeHolderText
{
    _placeHolderText = placeHolderText;
    [self setNeedsDisplay]; // refresh UI after property changed
}
/**
 *  设置占位文字颜色
 */
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    [self setNeedsDisplay]; // refresh UI after property changed
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay]; // refresh UI after property changed
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay]; // refresh UI after property changed
}
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay]; // refresh UI after property changed
}

-(void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    [self setNeedsDisplay]; // refresh UI after property changed
}

 
@end
