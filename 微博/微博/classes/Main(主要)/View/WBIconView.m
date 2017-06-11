//
//  WBIconView.m
//  微博
//
//  Created by BJT on 17/5/24.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "UIImageView+WebCache.h"

#import "WBIconView.h"
#import "WBUser.h"

@interface WBIconView ()

@property (nonatomic,weak) UIImageView *verifiedView;

@end

@implementation WBIconView

-(UIImageView *)verifiedView
{
    if (_verifiedView == nil) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        _verifiedView = verifiedView;
    }
    return _verifiedView;
}

-(void)setUser:(WBUser *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type) {
            
        case WBUserVerifiedPersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case WBUserVerifiedOrgEnterprice:
        case WBUserVerifiedOrgMedia:
        case WBUserVerifiedOrgWebsite:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case WBUserVerifiedDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES;
            break;
    }
    
    [self.verifiedView sizeToFit];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedView.x = self.width - self.verifiedView.width * 0.6;
    self.verifiedView.y = self.height - self.verifiedView.height * 0.6;
    
    
}

@end
