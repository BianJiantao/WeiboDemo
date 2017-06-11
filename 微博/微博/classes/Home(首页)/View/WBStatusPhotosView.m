//
//  WBStatusPhotosView.m
//  微博
//
//  Created by BJT on 17/5/24.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "WBStatusPhotosView.h"
#import "WBPhoto.h"
#import "WBStatusPhotoView.h"

/** 每一张配图宽度/高度 */
#define kWBPhotoViewWH 70
/** 配图间间距 */
#define kWBPhotoViewMargin 10
/** 最大配图列数 */
#define kWBPhotosViewMaxCol(count) ((count==4) ? 2 : 3)

@implementation WBStatusPhotosView


+ (CGSize)sizeWithPhotosCount:(NSInteger)count
{
    int maxCols = kWBPhotosViewMaxCol(count);
    
    NSInteger col = (count > maxCols) ? maxCols : count;
    NSInteger row = (count - 1) / maxCols + 1;
    
    CGFloat width = col * kWBPhotoViewWH + (col - 1) *  kWBPhotoViewMargin;
    CGFloat height = row * kWBPhotoViewWH + (row - 1) *  kWBPhotoViewMargin;
    return (CGSize){width,height};
}

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSInteger photosCount = photos.count;
    
    // cell 的 WBStatusPhotoView 循环利用
    while (self.subviews.count < photosCount) {
        
        WBStatusPhotoView *photoView = [[WBStatusPhotoView alloc] init];
        
        /** 添加点击手势,查看配图 */
        photoView.tag = self.subviews.count;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto:)];
        [photoView addGestureRecognizer:tap];
        
        [self addSubview:photoView];
    }
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        WBStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) {
            
            photoView.photo = photos[i];
            photoView.hidden = NO;
            
        }else{
            
            photoView.hidden = YES;
            
        }
    }
    
}

/**
 *  点击配图,查看大图
 */
-(void)tapPhoto:(UITapGestureRecognizer *)tap
{
    WBLog(@"%ld",tap.view.tag);
    
    NSMutableArray *photoArray = [NSMutableArray array];
    for (int i = 0; i < self.photos.count; i++) {
        WBPhoto *photo = self.photos[i];
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *picStr = [photo.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:picStr];
        p.index = i;
        p.srcImageView = (UIImageView *)tap.view;
        [photoArray addObject:p];
        
    }
    
    // 创建图片浏览器
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc] init];
    photoBrowser.photos = photoArray;
    photoBrowser.currentPhotoIndex = tap.view.tag;
    // 显示
    [photoBrowser show];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger photosCount = self.photos.count;
    int maxCols = kWBPhotosViewMaxCol(photosCount);
    
    for (int i = 0; i < photosCount; i++) {
        
        int col = i % maxCols;
        int row = i / maxCols;
        
        WBStatusPhotoView *photoView = self.subviews[i];
        photoView.x = col * (kWBPhotoViewWH + kWBPhotoViewMargin);
        photoView.y = row * (kWBPhotoViewWH + kWBPhotoViewMargin);
        photoView.width = kWBPhotoViewWH;
        photoView.height = kWBPhotoViewWH;
    }
    
}


@end
