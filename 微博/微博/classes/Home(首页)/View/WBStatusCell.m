//
//  WBStatusCell.m
//  微博
//
//  Created by BJT on 17/5/22.
//  Copyright © 2017年 BJT. All rights reserved.
//


#import "UIImageView+WebCache.h"

#import "WBStatusCell.h"
#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBPhoto.h"
#import "WBStatusToolBar.h"
#import "WBStatusPhotosView.h"
#import "WBIconView.h"
#import "WBStatusTextView.h"

@interface WBStatusCell ()  

/** 原创微博 original status */
@property (nonatomic,strong) UIView *originalView;
/** user icon */
@property (nonatomic,strong) WBIconView *iconView;
/** user name */
@property (nonatomic,strong) UILabel *nameLabel;
/** vip icon */
@property (nonatomic,strong) UIImageView *vipView;
/**  time when status is created */
@property (nonatomic,strong) UILabel *timeLabel;
/** status source */
@property (nonatomic,strong) UILabel *sourceLabel;
/** status main text */
@property (nonatomic,strong) WBStatusTextView *textContentView;
/** status photos */
@property (nonatomic,strong) WBStatusPhotosView *photosView;

/** 被转发微博 retweeted status */
@property (nonatomic,strong) UIView *retweetView;
/** retweeted status main text */
@property (nonatomic,strong) WBStatusTextView *retweetTextContentView;
/** retweeted status photos */
@property (nonatomic,strong) WBStatusPhotosView *retweetPhotosView;

/** 微博工具条 status tool bar */
@property (nonatomic,strong) WBStatusToolBar *toolBar;

@end



@implementation WBStatusCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // setup Original Status
        [self setupOriginalStatus];
        // setup Retweet Status
        [self setupRetweetStatus];
        // setup Status toolBar
        [self setupToolBar];
     }
    
    return self;
}

/** setup original status  */
-(void)setupOriginalStatus
{
    
    /** original status */
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** user icon */
    WBIconView *iconView = [[WBIconView alloc] init];
    [self.originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** user name */
    UILabel *nameLabel= [[UILabel alloc] init];
    [self.originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    self.nameLabel.font = kWBStatusCellNameFont;
    
    /** vip icon */
    UIImageView *vipView= [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [self.originalView addSubview:vipView];
    self.vipView = vipView;
    
    /**  time when status is created */
    UILabel *timeLabel= [[UILabel alloc] init];
    [self.originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    self.timeLabel.font = kWBStatusCellTimeFont;
    self.timeLabel.textColor = [UIColor orangeColor];
    
    /** status source */
    UILabel *sourceLabel= [[UILabel alloc] init];
    [self.originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    self.sourceLabel.font = kWBStatusCellSourceFont;
    self.sourceLabel.textColor = [UIColor grayColor];
    
    /** status main text */ 
    WBStatusTextView *textContentView= [[WBStatusTextView alloc] init];
    [self.originalView addSubview:textContentView];
    self.textContentView = textContentView;
    
    /** status photos */
    WBStatusPhotosView *photosView = [[WBStatusPhotosView alloc] init];
//    photosView.backgroundColor = [UIColor redColor];
    [self.originalView addSubview:photosView];
    self.photosView = photosView;

}

/** setup retweet status  */
- (void)setupRetweetStatus
{
    
    /** retweet status */
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = kRGBColor(247, 247, 247);
    self.retweetView = retweetView;
    
    /** retweet status content */
    WBStatusTextView *retweetTextContentView= [[WBStatusTextView alloc] init];
    [self.retweetView addSubview:retweetTextContentView];
    self.retweetTextContentView = retweetTextContentView;
    
    /** retweet status photos */
    WBStatusPhotosView *retweetPhotosView = [[WBStatusPhotosView alloc] init];
//    retweetPhotosView.backgroundColor = [UIColor greenColor];
    [self.retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;

    
}

/** setup toolBar status */
- (void)setupToolBar
{
    WBStatusToolBar *toolBar = [WBStatusToolBar toolBar];
//    toolBar.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
}


-(void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    WBStatus *status = statusFrame.status;
    WBUser *user = status.user;
    
// set subView frame and content
    /** original status View */
    self.originalView.frame = statusFrame.originalViewF;
    
    /** user icon */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    /** user name */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    /** vip icon */
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipRank = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipRank];
        self.nameLabel.textColor = [UIColor orangeColor];
        
    }else{
        
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /**  time when status is created */
    NSString *created_at = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = created_at;
    // reset timeLabel size  when time updates
    self.timeLabel.size = [created_at sizeWithTextFont:kWBStatusCellTimeFont];
    
    /** status source */
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = status.source;
    // reset sourceLabel origin.x  when time updates
    self.sourceLabel.x = CGRectGetMaxX(self.timeLabel.frame) + kWBStatusCellBorderWidth;
    
    /** status main text */
    self.textContentView.frame = statusFrame.textContentLabelF;
    self.textContentView.attributedText = status.attributedText;
    
    /** status photos */
    if(status.pic_urls.count){
        
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
    /** retweet status View */
    WBStatus *retweeted_status = status.retweeted_status;
    if (retweeted_status) {
        
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** retweet status text content */
        self.retweetTextContentView.frame = statusFrame.retweetTextContentLabelF;
        self.retweetTextContentView.attributedText = status.retweetedAttributedText;
        
        /** retweet status photos */
        if(retweeted_status.pic_urls.count){
            
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
            
        }else{
            self.retweetPhotosView.hidden = YES;
        }
        
        
    }else{
        
        self.retweetView.hidden = YES;
    }
    
    self.toolBar.frame = statusFrame.toolBarF;
    self.toolBar.status = status;
    
}



@end
