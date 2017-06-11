//
//  WBEmotionTabbarButton.m
//  微博
//
//  Created by BJT on 17/5/29.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBEmotionTabbarButton.h"

@implementation WBEmotionTabbarButton

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  重写该方法,取消按钮高亮
 *
 */
-(void)setHighlighted:(BOOL)highlighted
{
    
}

@end
