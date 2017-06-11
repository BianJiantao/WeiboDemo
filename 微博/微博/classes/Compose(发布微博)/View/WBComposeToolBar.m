//
//  WBComposeToolBar.m
//  微博
//
//  Created by BJT on 17/5/26.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBComposeToolBar.h"

@interface WBComposeToolBar ()

/**
 *  表情按钮
 */
@property (nonatomic,weak) UIButton *emotionBtn;

@end


@implementation WBComposeToolBar


-(instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setupBtnWithImage:@"compose_camerabutton_background" highlightedImage:@"compose_camerabutton_background_highlighted" btnType:WBComposeToolBarBtnTypeCamera];
        [self setupBtnWithImage:@"compose_toolbar_picture" highlightedImage:@"compose_toolbar_picture_highlighted" btnType:WBComposeToolBarBtnTypePicture];
        [self setupBtnWithImage:@"compose_mentionbutton_background" highlightedImage:@"compose_mentionbutton_background_highlighted" btnType:WBComposeToolBarBtnTypeMention];
        [self setupBtnWithImage:@"compose_trendbutton_background" highlightedImage:@"compose_trendbutton_background_highlighted" btnType:WBComposeToolBarBtnTypeTrend];
        self.emotionBtn =  [self setupBtnWithImage:@"compose_emoticonbutton_background" highlightedImage:@"compose_emoticonbutton_background_highlighted" btnType:WBComposeToolBarBtnTypeEmotion];
    }
    return self;
}

- ( UIButton *)setupBtnWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage btnType:(WBComposeToolBarBtnType)buttonType
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    btn.tag = buttonType;
    [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}
 
-(void)layoutSubviews
{
    [super layoutSubviews];  
    
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount ; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
}

-(void)btnDidClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:DidClickBtnType:)]) {
        [self.delegate composeToolbar:self DidClickBtnType:btn.tag];
    }
}

-(void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
    // 默认显示表情图片
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    
    if (showKeyboardButton) { // 显示键盘图片
        
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    
    [self.emotionBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    
}


@end
