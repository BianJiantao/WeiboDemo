//
//  WBStatusPhotosView.h
//  微博
//
//  Created by BJT on 17/5/24.
//  Copyright © 2017年 BJT. All rights reserved.
// 微博配图相册

#import <UIKit/UIKit.h>

@interface WBStatusPhotosView : UIView

/**
 *  WBPhoto models
 */
@property (nonatomic,strong) NSArray *photos;

/**
 *  get PhotosView size by photos count
 *
 */
+ (CGSize)sizeWithPhotosCount:(NSInteger)count;

@end
