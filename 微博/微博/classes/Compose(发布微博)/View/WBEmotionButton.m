//
//  WBEmotionButton.m
//  微博
//
//  Created by BJT on 17/6/1.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBEmotionButton.h"
#import "WBEmotion.h"

@implementation WBEmotionButton

-(instancetype)init
{
    self = [super init];
    if (self) {
        // emoji 表情是字符串, 通过设置字体大小改变表情大小
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}


-(void)setEmotion:(WBEmotion *)emotion
{
    _emotion = emotion;
    if (emotion.png) {
        
        UIImage *img = [UIImage imageNamed:emotion.png];
        [self setImage:img forState:UIControlStateNormal];
        
    }else if(emotion.code){ // emoji
        
        [self setTitle:[emotion.code emoji] forState:UIControlStateNormal];
    }
}

@end
