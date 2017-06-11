//
//  WBEmotionPageView.m
//  微博
//
//  Created by BJT on 17/5/29.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBEmotionPageView.h"
#import "WBEmotion.h"
#import "WBEmotionDetailView.h"
#import "WBEmotionButton.h"
#import "WBEmotionTool.h"

// pageView的内边距
#define kPageViewInset 10

@interface WBEmotionPageView ()

/**
 *  显示放大的表情
 */
@property (nonatomic,strong) WBEmotionDetailView *emotionDetailView;

/**
 *  每页表情列表最后的删除按钮
 */
@property (nonatomic,weak) UIButton *deleteBtn;


@end


@implementation WBEmotionPageView

- (WBEmotionDetailView *)emotionDetailView
{
    if (_emotionDetailView == nil) {
        _emotionDetailView = [[WBEmotionDetailView alloc] init];
    }
    return _emotionDetailView;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        // 表情删除按钮
        UIButton *deleteBtn = [[UIButton alloc] init];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(deleteBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        
        // 添加长按手势识别器
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
        [self addGestureRecognizer:longPress];
        [longPress addTarget:self action:@selector(longPressPageView:)];
        
    }
    return self;
}


-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions; 
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {     
        
        WBEmotionButton *btn = [[WBEmotionButton alloc] init];
        btn.emotion = emotions[i];
//        btn.backgroundColor = kRandomColor;

        [self addSubview:btn];
        [btn addTarget:self action:@selector(emotionBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger btnCount = self.emotions.count;
    CGFloat btnW = (self.width - 2 * kPageViewInset) / kPageEmotionMaxCol;
    CGFloat btnH = (self.height - kPageViewInset) / kPageEmotionMaxRow;
    for (int i = 0; i<btnCount ; i++) {
        
        int col = i % kPageEmotionMaxCol;
        int row = i / kPageEmotionMaxCol;
        
        // i=0时是删除按钮
        WBEmotionButton *btn = self.subviews[i+1];
        btn.x = kPageViewInset +  col * btnW;
        btn.y = kPageViewInset +  row * btnH;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.x = self.width - btnW;
    self.deleteBtn.y = self.height - btnH;
    
}

/**
 *  监听长按手势
 */
-(void)longPressPageView:(UILongPressGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self];
    WBEmotionButton *btn = [self emotionBtnWithGestureLocation:location];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            [self.emotionDetailView showFrom:btn];
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.emotionDetailView removeFromSuperview];
            
            if (btn) { // 长按后选中了某一个表情,发出通知
                [self selectEmotion:btn.emotion];
            }
            
            break;
            
         default:
            break;
            
    }
    
    
    
}

/**
 *  获取 location 所在位置的表情按钮
 */
-(WBEmotionButton *)emotionBtnWithGestureLocation:(CGPoint)location
{
    for (int i = 0; i < self.emotions.count; i++) {
        
        WBEmotionButton *btn = self.subviews[i+1];
        if(CGRectContainsPoint(btn.frame, location)){
            return btn;
        }
    }
    return nil;
}

-(void)deleteBtnDidClick
{
    [WBNotificationCenter postNotificationName:WBEmotionDidDeleteNotification object:nil];
}

- (void)emotionBtnDidClick:(WBEmotionButton *)btn
{
//    WBLog(@"----%@",btn.emotion);
    [self.emotionDetailView showFrom:btn];
    
    // 0.25秒后移除表情放大视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.emotionDetailView removeFromSuperview];
    });
    
    [self selectEmotion:btn.emotion]; // 发出选中表情的通知
    
}

/**
 *  发出选中表情的通知
 */
-(void)selectEmotion:(WBEmotion *)emotion
{
    // 表情存入沙盒
    [WBEmotionTool addEmotion:emotion];
    
    NSMutableDictionary *userInfoDict = [NSMutableDictionary dictionary];
    userInfoDict[WBEmotionDidSelectKey] = emotion;
    
    // 发出通知告诉控制器
    [WBNotificationCenter postNotificationName:WBEmotionDidSelectNotification object:nil userInfo:userInfoDict];
}

@end
