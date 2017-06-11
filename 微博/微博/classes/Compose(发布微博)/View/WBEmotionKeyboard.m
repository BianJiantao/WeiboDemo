//
//  WBEmotionKeyboard.m
//  微博
//
//  Created by BJT on 17/5/27.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "MJExtension.h"

#import "WBEmotionKeyboard.h"
#import "WBEmotionTabbar.h"
#import "WBEmotionListView.h"
#import "WBEmotion.h"
#import "WBEmotionTool.h"

@interface WBEmotionKeyboard () <WBEmotionTabbarDelegate>

/**
 *  表情键盘底部工具条
 */
@property (nonatomic,weak) WBEmotionTabbar *emotionTabbar;

/**
 *  当前正在显示的表情列表
 */
@property (nonatomic,weak) WBEmotionListView *showingListView;
/**
 *  最近表情列表
 */
@property (nonatomic,strong) WBEmotionListView *recentListView;
/**
 *  默认表情列表
 */
@property (nonatomic,strong) WBEmotionListView *defaultListView;
/**
 *  emoji 表情列表
 */
@property (nonatomic,strong) WBEmotionListView *emojiListView;
/**
 *  浪小花表情列表
 */
@property (nonatomic,strong) WBEmotionListView *lxhListView;

@end


@implementation WBEmotionKeyboard

#pragma  mark -懒加载
- (WBEmotionListView *)recentListView
{
    if (_recentListView == nil) {
        _recentListView = [[WBEmotionListView alloc] init];
//        // 从沙盒加载最近表情
        _recentListView.emotions = [WBEmotionTool recentEmotions];
//        _recentListView.backgroundColor = kRandomColor;
    }
        
    return _recentListView;
}
- (WBEmotionListView *)defaultListView
{
    if (_defaultListView == nil) {
        _defaultListView = [[WBEmotionListView alloc] init];
        _defaultListView.emotions = [WBEmotionTool defaultEmotions];
        
//        _defaultListView.backgroundColor = kRandomColor;
    }
    return _defaultListView;
}
- (WBEmotionListView *)emojiListView
{
    if (_emojiListView == nil) {
        _emojiListView = [[WBEmotionListView alloc] init];
        _emojiListView.emotions = [WBEmotionTool emojiEmotions];
        
//        _emojiListView.backgroundColor = kRandomColor;
    }
    return _emojiListView;
}
- (WBEmotionListView *)lxhListView
{
    if (_lxhListView == nil) {
        _lxhListView = [[WBEmotionListView alloc] init];
        _lxhListView.emotions = [WBEmotionTool lxhEmotions];
        
//        _lxhListView.backgroundColor = kRandomColor;
    }
    return _lxhListView;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        WBEmotionTabbar *emotionTabbar = [[WBEmotionTabbar alloc] init];
        [self addSubview:emotionTabbar];
        emotionTabbar.delegate = self;
        self.emotionTabbar = emotionTabbar;
        [WBNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:WBEmotionDidSelectNotification object:nil];
        
    }
    return self;
}

-(void)dealloc
{
    [WBNotificationCenter removeObserver:self];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.emotionTabbar.width = self.width;
    self.emotionTabbar.height = 37;
    self.emotionTabbar.x = 0;
    self.emotionTabbar.y = self.height - self.emotionTabbar.height;
    
    self.showingListView.width = self.width;
    self.showingListView.height = self.emotionTabbar.y;
    self.showingListView.x = self.showingListView.y = 0;
}

#pragma mark -WBEmotionTabbarDelegate
/**
 *  点击工具条按钮,切换表情列表
 */
-(void)emotionTabbar:(WBEmotionTabbar *)tabbar didClickButton:(WBEmotionTabbarButtonType)buttonType
{
//    WBLog(@"---%ld",buttonType);
    [self.showingListView removeFromSuperview];
    
    switch (buttonType) {
        case WBEmotionTabbarButtonTypeRecent:
//            WBLog(@"最近");
            self.showingListView = self.recentListView;
            break;
            
        case WBEmotionTabbarButtonTypeDefult:
//            WBLog(@"默认");
            self.showingListView = self.defaultListView;
            break;
            
        case WBEmotionTabbarButtonTypeEmoji:
//            WBLog(@"Emoji");
            self.showingListView = self.emojiListView;
            break;
            
        case WBEmotionTabbarButtonTypeLxh:
//            WBLog(@"浪小花");
            self.showingListView = self.lxhListView;
            break;
            
    }
    [self addSubview:self.showingListView];
//    [self setNeedsLayout];
    
//    WBLog(@"%@",NSStringFromCGRect(self.showingListView.frame));
}
#pragma mark - 监听通知方法
-(void)emotionDidSelect
{
    self.recentListView.emotions = [WBEmotionTool recentEmotions];
}

@end
