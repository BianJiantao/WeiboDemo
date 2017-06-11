//
//  WBDropDownMenu.m
//  微博
//
//  Created by BJT on 17/5/16.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBDropDownMenu.h"

@interface WBDropDownMenu()
/**
 *  store menu content
 */
@property (nonatomic,weak) UIImageView *containerView;

@end


@implementation WBDropDownMenu

-(UIImageView *)containerView
{
    if (_containerView == nil) {
        
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        // enable userInteraction
        containerView.userInteractionEnabled = YES;
        
        [self addSubview:containerView];
        _containerView  = containerView;
    }
    return _containerView;
}

-(void)setContent:(UIView *)content
{
    _content = content;
    content.x = 10;
    content.y = 15;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    [self.containerView addSubview:content];
}

-(void)setContentVc:(UIViewController *)contentVc
{
    _contentVc = contentVc;
    
    // set dropdownMenu's content 
    self.content = contentVc.view;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)menu
{
    return [[self alloc] init];
}

-(void)showFrom:(UIView *)from
{
    // get the top window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // set menu frame
    self.frame = window.bounds;
    // add menu to the window
    [window addSubview:self];

    // Convert coordinate system
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        [self.delegate dropDownMenuDidShow:self];
    }


}

-(void)dismiss
{
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.delegate dropDownMenuDidDismiss:self];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}


@end
