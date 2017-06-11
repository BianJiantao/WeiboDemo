//
//  WBEmotionListView.m
//  微博
//
//  Created by BJT on 17/5/29.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBEmotionListView.h"
#import "WBEmotionPageView.h"
#import "WBPageControl.h"


@interface WBEmotionListView () <UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *emotionView;
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation WBEmotionListView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 1. scrollview
        UIScrollView *emotionView = [[UIScrollView alloc] init];
        [self addSubview:emotionView];
        self.emotionView = emotionView;
        emotionView.delegate = self;
        emotionView.pagingEnabled = YES;
        emotionView.showsHorizontalScrollIndicator = NO;
        emotionView.showsVerticalScrollIndicator = NO;
//        emotionView.backgroundColor = kRandomColor;
        
        // 2. pagecontrol
        WBPageControl *pageControl = [[WBPageControl alloc] init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        pageControl.enabled = NO;
        pageControl.hidesForSinglePage = YES;
        // 设置 pagecontrol 圆点背景图片
        pageControl.activeImage = [UIImage imageNamed:@"compose_keyboard_dot_selected"];
        pageControl.inactiveImage = [UIImage imageNamed:@"compose_keyboard_dot_normal"];
        
//        pageControl.currentPageIndicatorTintColor = kRGBColor(247, 109, 8);
//        pageControl.pageIndicatorTintColor = kRGBColor(196,196,196);
//        pageControl.backgroundColor = kRandomColor;
        

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 30;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.emotionView.width = self.width;
    self.emotionView.height = self.pageControl.y;
    self.emotionView.x = self.emotionView.y = 0;
    
    NSUInteger count = self.emotionView.subviews.count;
    for (int i = 0; i < count; i++) {
        WBEmotionPageView *pageView = self.emotionView.subviews[i];
        pageView.x = i * self.emotionView.width;
        pageView.y = 0;
        pageView.width = self.emotionView.width;
        pageView.height = self.emotionView.height;
    }
    self.emotionView.contentSize = CGSizeMake(count * self.emotionView.width, 0);
    
}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger emotionCount = emotions.count;
    if(emotionCount  == 0) return;
    
    // 显示所有表情所需页数
    NSUInteger pageCount = (emotionCount - 1) / kPageEmotionCount + 1;
    self.pageControl.numberOfPages = pageCount;

    // 切换到 最近 表情选项卡时, 要清楚之前的 WBEmotionPageView 控件,否则切换时会分页错乱
    [self.emotionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    for (int i = 0; i < pageCount; i++) {
        
        WBEmotionPageView *pageView = [[WBEmotionPageView alloc] init];
        [self.emotionView addSubview:pageView];
        NSRange range;
        range.location = i * kPageEmotionCount;
        // 最后一页 截取剩余表情数
        range.length = (i == pageCount -1 )?(emotionCount - range.location) : kPageEmotionCount;
        // 截取每页所需显示的表情数组,进行赋值
        pageView.emotions = [emotions subarrayWithRange:range];
        
    }
    [self setNeedsLayout];
    
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page =  scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
}


@end
