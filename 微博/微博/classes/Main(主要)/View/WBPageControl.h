//
//  WBPageControl.h
//  微博
//
//  Created by BJT on 17/5/30.
//  Copyright © 2017年 BJT. All rights reserved.
// 自定义 PageControl , 设置圆点图片

#import <UIKit/UIKit.h>

@interface WBPageControl : UIPageControl

/**
 *  选中时的背景图片
 */
@property (nonatomic,strong) UIImage *activeImage;
/**
 *  未选中时的背景图片
 */
@property (nonatomic,strong) UIImage *inactiveImage;

@end
