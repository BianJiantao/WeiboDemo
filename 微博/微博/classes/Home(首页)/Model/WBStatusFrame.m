//
//  WBStatusFrame.m
//  微博
//
//  Created by BJT on 17/5/22.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBStatusPhotosView.h"

/** cell margin */
#define kWBStatusCellMargin 15

@implementation WBStatusFrame


-(void)setStatus:(WBStatus *)status
{
    _status = status;
    WBUser *user = status.user;
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    // calculate subView frame
    
    /** user icon */
    CGFloat iconWH = 35;
    CGFloat iconX = kWBStatusCellBorderWidth;
    CGFloat iconY = kWBStatusCellBorderWidth;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** user name */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + kWBStatusCellBorderWidth;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithTextFont:kWBStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /** vip icon */
    if (user.isVip) {
        
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + kWBStatusCellBorderWidth;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /**  time when status is created */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + kWBStatusCellBorderWidth;
    CGSize timeSize = [status.created_at sizeWithTextFont:kWBStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    /** status source */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + kWBStatusCellBorderWidth;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithTextFont:kWBStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    /** status main text */
    CGFloat textContentX = iconX;
    CGFloat textContentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + kWBStatusCellBorderWidth;
    CGFloat maxW = cellWidth - 2 * textContentX;
    CGSize textContentSize = [status.attributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textContentLabelF = (CGRect){{textContentX,textContentY},textContentSize};
    
    /** status photos */
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        
        CGFloat photosX = textContentX;
        CGFloat photosY = CGRectGetMaxY(self.textContentLabelF) + kWBStatusCellBorderWidth;
        CGSize photosSzie = [WBStatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photosX,photosY},photosSzie};
        
        originalH = CGRectGetMaxY(self.photosViewF) + kWBStatusCellBorderWidth;
        
    }else{
        
        originalH = CGRectGetMaxY(self.textContentLabelF) + kWBStatusCellBorderWidth;
    }
    
    /** original status */
    CGFloat originalX = 0;
    CGFloat originalY = kWBStatusCellMargin; // set margin between the cell
    CGFloat originalW = cellWidth ;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    /** retweet status */
    CGFloat toolBarY = 0; //  toolBar origin.y
    WBStatus *retweeted_status = status.retweeted_status;
    if (retweeted_status) {
        
        /** retweet status text content */
        CGFloat retweetTextContentX = kWBStatusCellBorderWidth;
        CGFloat retweetTextContentY = kWBStatusCellBorderWidth;
        CGSize retweetTextContentSize = [status.retweetedAttributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        self.retweetTextContentLabelF = (CGRect){{retweetTextContentX,retweetTextContentY},retweetTextContentSize};
        
        /** retweet status photos */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) {
            
            CGFloat retweetPhotosX = retweetTextContentX;
            CGFloat retweetPhotosY= CGRectGetMaxY(self.retweetTextContentLabelF) + kWBStatusCellBorderWidth;
            CGSize retweetPhotosSzie = [WBStatusPhotosView sizeWithPhotosCount:retweeted_status.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotosX,retweetPhotosY},retweetPhotosSzie};
            
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + kWBStatusCellBorderWidth;
            
        }else{
            
            retweetH = CGRectGetMaxY(self.retweetTextContentLabelF) + kWBStatusCellBorderWidth;
        }
        
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellWidth;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        /** toolBar origin.y  */
        toolBarY = CGRectGetMaxY(self.retweetViewF);
        
    }else{
        
        /** toolBar origin.y */
        toolBarY = CGRectGetMaxY(self.originalViewF);
        
    }
    
    /** status toolBar */
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellWidth;
    CGFloat toolBarH = 36;
    self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    /** cell height */
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
}

@end
