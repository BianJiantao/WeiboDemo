//
//  WBEmotionPageView.h
//  微博
//
//  Created by BJT on 17/5/29.
//  Copyright © 2017年 BJT. All rights reserved.
// 显示表情的控件 (scrollView 滚动的每一页表情视图)

#import <UIKit/UIKit.h>

/**每页表情最大列数*/
# define kPageEmotionMaxCol  7
/**每页表情最大行数*/
#define kPageEmotionMaxRow 3
/**每页表情个数*/
#define kPageEmotionCount ((kPageEmotionMaxRow * kPageEmotionMaxCol)-1)


@interface WBEmotionPageView : UIView

/**
 *  表情模型数组
 */
@property (nonatomic,strong) NSArray *emotions;

@end
