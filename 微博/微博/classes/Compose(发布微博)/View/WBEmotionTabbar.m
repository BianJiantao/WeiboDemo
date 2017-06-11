//
//  WBEmotionTabbar.m
//  微博
//
//  Created by BJT on 17/5/29.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBEmotionTabbar.h"
#import "WBEmotionTabbarButton.h"

@interface WBEmotionTabbar ()

/**
 *  当前选中的按钮
 */
@property (nonatomic,weak) WBEmotionTabbarButton *selectedBtn;

@end


@implementation WBEmotionTabbar

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupBtnWithButtonType:WBEmotionTabbarButtonTypeRecent Title:@"最近"];
        [self setupBtnWithButtonType:WBEmotionTabbarButtonTypeDefult Title:@"默认"];
        [self setupBtnWithButtonType:WBEmotionTabbarButtonTypeEmoji Title:@"Emoji"];
        [self setupBtnWithButtonType:WBEmotionTabbarButtonTypeLxh Title:@"浪小花"];
    }
    return self;
}

-(void)setupBtnWithButtonType:(WBEmotionTabbarButtonType)buttonType Title:(NSString *)title
{
    WBEmotionTabbarButton *btn = [[WBEmotionTabbarButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    
    NSString *image = @"compose_emotion_table_mid_normal"; // middle button
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 0) {  // left button
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }else if (self.subviews.count == 3){  // right button
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
        
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(buttonDidClicik:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [self addSubview:btn];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount ; i++) {
        WBEmotionTabbarButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
}

-(void)setDelegate:(id<WBEmotionTabbarDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选中 默认表情按钮
    [self buttonDidClicik:(WBEmotionTabbarButton *)[self viewWithTag:WBEmotionTabbarButtonTypeDefult]];
}

-(void)buttonDidClicik:(WBEmotionTabbarButton *)button
{
    if (button.selected)  return;  // 点击按钮是选中按钮,直接返回
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabbar:didClickButton:)]) {
        [self.delegate emotionTabbar:self didClickButton:button.tag];
    }
    
}


@end
