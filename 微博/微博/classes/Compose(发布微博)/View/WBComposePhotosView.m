//
//  WBComposePhotosView.m
//  微博
//
//  Created by BJT on 17/5/26.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBComposePhotosView.h"

@implementation WBComposePhotosView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

-(void)addPhoto:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
    
    [self.photos addObject:image];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat photoWH = 70;
    CGFloat photoMargin = (self.width - maxCol * photoWH) / (maxCol + 1);
    
    for (int i = 0; i < count; i++) {
        UIImageView *imageV = self.subviews[i];
        
        int col = i % maxCol ;
        int row = i / maxCol;
        
        imageV.x = col * (photoWH + photoMargin) + photoMargin;
        imageV.y = row * (photoWH + photoMargin);
        imageV.width = photoWH;
        imageV.height = photoWH;
    }
    
}


@end
