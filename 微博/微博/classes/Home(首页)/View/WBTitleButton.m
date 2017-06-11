//
//  WBTitleButton.m
//  微博
//
//  Created by BJT on 17/5/19.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBTitleButton.h"

#define WBMargin 10

@implementation WBTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
        
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


//-(void)setFrame:(CGRect)frame
//{
//    
//    WBLog(@"%@",NSStringFromCGRect(frame));
//    frame.size.width += WBMargin;
//    [super setFrame:frame];
//    
////    WBLog(@"%@",NSStringFromCGRect(frame));
//}

/**
 *  reset title Button size
 */
-(void)sizeToFit
{
    [super sizeToFit];
    
    self.width += WBMargin;
    
//    WBLog(@"%@",NSStringFromCGRect(self.frame));
}

/**
 *  reset frame of imageView and  titleLabel
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = 0;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + WBMargin ;
}

/**
 *  set button sizeToFit when button title content changed
 */
-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    
}

/**
 *  set button sizeToFit when button image content changed
 */
-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
