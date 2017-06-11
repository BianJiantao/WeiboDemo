//
//  WBComposePhotosView.h
//  微博
//
//  Created by BJT on 17/5/26.
//  Copyright © 2017年 BJT. All rights reserved.
// 显示选中的图片

#import <UIKit/UIKit.h>

@interface WBComposePhotosView : UIView

/**
 *  add selected photo
 */
-(void)addPhoto:(UIImage *)image;
/**
 *  photos in the photosView
 */
@property (nonatomic,strong,readonly) NSMutableArray *photos;

@end
