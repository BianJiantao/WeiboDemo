//
//  WBTabbar.m
//  微博
//
//  Created by BJT on 17/5/17.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBTabbar.h"

@interface WBTabbar ()
@property (nonatomic,weak) UIButton *plusBtn;

@end

@implementation WBTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
        
    }
    return self;
}

- (void)plusBtnDidClick
{
    if ([self.delegate respondsToSelector:@selector(tabbarDidClickPlusButton:)]) {
        [self.delegate tabbarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    WBLog(@"%@",self.subviews);
    
    // set plusButton frame
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;

    CGFloat tabbarBtnW = self.width / 5;
    NSInteger tabbarBtnIndex = 0;
    
    // reset UITabBarButton frame
    for (UIView *child in self.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {

            child.width = tabbarBtnW;
            child.x = tabbarBtnIndex * tabbarBtnW;
            
            tabbarBtnIndex++;
            if (tabbarBtnIndex == 2) {// skip plus button
                tabbarBtnIndex++;
            }
        }
    }
    
}

@end
