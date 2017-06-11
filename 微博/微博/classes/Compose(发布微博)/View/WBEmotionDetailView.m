//
//  WBEmotionDetailView.m
//  微博
//
//  Created by BJT on 17/5/31.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBEmotionDetailView.h"
#import "WBEmotionButton.h"

@interface WBEmotionDetailView ()

@property (nonatomic,weak) WBEmotionButton *emotionBtn;

@end

@implementation WBEmotionDetailView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier"];
        [self sizeToFit];
        WBEmotionButton *btn = [[WBEmotionButton alloc] init];
        [self addSubview:btn];
        self.emotionBtn = btn;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    WBEmotionButton *btn = [self.subviews lastObject];
    btn.height = btn.width = self.width;
    btn.x = btn.y = 0;
    
}

-(void)showFrom:(WBEmotionButton *)btn
{
    self.emotionBtn.emotion = btn.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    CGRect newFrame = [btn convertRect:btn.bounds toView:window];
    
    self.centerX = CGRectGetMidX(newFrame);
    self.y = CGRectGetMidY(newFrame) - self.height;
    
    [window addSubview:self];
    
}



@end
