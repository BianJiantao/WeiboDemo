//
//  WBStatusTextView.m
//  微博
//
//  Created by BJT on 17/6/6.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBStatusTextView.h"
#import "WBStatusSpecialText.h"

#define kBGViewTag 999

@implementation WBStatusTextView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.scrollEnabled = NO;
        // 调整文字左右内边距
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        
    }
    return self;
}

-(void)setupSpecialRects
{
    NSMutableArray *specialArray = [NSMutableArray array];
    
    self.selectable = YES; // 开启选中属性,计算 selectionRects
    // 取出特殊文本模型数组
    NSArray *specials = [self.attributedText attribute:kWBStatusSpecialTextKey atIndex:0 effectiveRange:NULL];
    // 遍历每一个特殊文本
    for (WBStatusSpecialText *special in specials) {
        
        self.selectedRange = special.range;
        
        NSArray *rectArray = [self selectionRectsForRange:self.selectedTextRange];
        self.selectedRange = NSMakeRange(0, 0);
        
//        WBLog(@"rectArray%@",rectArray);
        
        NSMutableArray *temp = [NSMutableArray array];
        for (UITextSelectionRect *selectionRect in rectArray) {
            CGRect rect = selectionRect.rect;
            if(rect.size.width == 0 || rect.size.height == 0 ) continue;
            [temp addObject:[NSValue valueWithCGRect:rect]] ;
        }
        special.rects = temp;
        [specialArray addObject:special];
    }
    _specials = specialArray;
    
    //    WBLog(@"%@",_specials);
//    self.selectable = NO; //  关闭选中属性, 取消长按复制粘贴放大功能
    
}


/**
 *  获取触摸点所在的特殊文本
 */
-(WBStatusSpecialText *)specialTextWithTouchLocation:(CGPoint)location
{
    // 遍历当前点击微博的所有特殊文本
    for (WBStatusSpecialText *special in self.specials) {
        
        // 遍历特殊文本的矩形框
        for (NSValue *rectValue in special.rects) {
            
            CGRect rect = rectValue.CGRectValue;
            if (CGRectContainsPoint(rect, location)) {
                
                return special;
            }
            
        }
        
    }

    return nil;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    // 获取触摸点位置
    CGPoint location = [touch locationInView:self];
    
    [self setupSpecialRects];
    WBStatusSpecialText *special = [self specialTextWithTouchLocation:location];
//     WBLog(@"%@",special.rects);
    
    for (NSValue *rectValue in special.rects) {
        
        CGRect rect = rectValue.CGRectValue;
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = [UIColor greenColor];
        bg.frame = rect;
        bg.tag = kBGViewTag;
        bg.layer.cornerRadius = 5;
        [self insertSubview:bg atIndex:0];
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    WBLog(@"touchesEnded---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self touchesCancelled:touches withEvent:event];
    });
    

}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    WBLog(@"touchesCancelled-------");
    for (UIView *child in self.subviews) {
        if (child.tag == kBGViewTag)
            [child removeFromSuperview];
    }
}



-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
//    WBLog(@"%@",NSStringFromCGPoint(point));
    
    [self setupSpecialRects];
    WBStatusSpecialText *special = [self specialTextWithTouchLocation:point];
    if (special)  // 点击特殊文本时, 自己处理
        return YES;
    else         // 点击其他区域时,不处理,由其他控件处理( tableViewController 的 cell 点击 )
        return NO;
}


@end
