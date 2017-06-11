//
//  WBEmotionAttachment.m
//  微博
//
//  Created by BJT on 17/6/2.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBEmotionAttachment.h"
#import "WBEmotion.h"

@implementation WBEmotionAttachment

-(void)setEmotion:(WBEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}

@end
