//
//  WBStatusPhotoView.m
//  微博
//
//  Created by BJT on 17/5/24.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"

@interface WBStatusPhotoView ()

@property (nonatomic,weak) UIImageView *gifView;

@end

@implementation WBStatusPhotoView

-(instancetype)init{
    if (self = [super init]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(UIImageView *)gifView
{
    if (_gifView == nil) {
        UIImage *gif = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:gif];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return _gifView;
}

-(void)setPhoto:(WBPhoto *)photo
{
    _photo = photo;
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
 
    // lowercaseString 转为 小写 字母, 避免大写 GIF 后缀时不能识别
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
    
}

@end
