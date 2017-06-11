//
//  WBStatusFrame.h
//  微博
//
//  Created by BJT on 17/5/22.
//  Copyright © 2017年 BJT. All rights reserved.
// MVVM
//status Frame model
//

#import <Foundation/Foundation.h>

/** cell border width  */
#define kWBStatusCellBorderWidth 10

/** name font size */
#define kWBStatusCellNameFont [UIFont systemFontOfSize:14]

/** time font size */
#define kWBStatusCellTimeFont [UIFont systemFontOfSize:12]

/** source font size */
#define kWBStatusCellSourceFont kWBStatusCellTimeFont


@class WBStatus;

@interface WBStatusFrame : NSObject

/** status model */
@property (nonatomic,strong) WBStatus *status;

/** original status */
@property (nonatomic,assign) CGRect originalViewF;
/** user icon */
@property (nonatomic,assign) CGRect iconViewF;
/** user name */
@property (nonatomic,assign) CGRect nameLabelF;
/** vip icon */
@property (nonatomic,assign) CGRect vipViewF;
/**  time when status is created */
@property (nonatomic,assign) CGRect timeLabelF;
/** status source */
@property (nonatomic,assign) CGRect sourceLabelF;
/** status main text */
@property (nonatomic,assign) CGRect textContentLabelF;
/** status photos */
@property (nonatomic,assign) CGRect photosViewF;


/** retweet status */
@property (nonatomic,assign) CGRect retweetViewF;
/** retweet status main text */
@property (nonatomic,assign) CGRect retweetTextContentLabelF;
/** retweet status photos */
@property (nonatomic,assign) CGRect retweetPhotosViewF;


/** status toolBar */
@property (nonatomic,assign) CGRect toolBarF;

/** cell height */
@property (nonatomic,assign) CGFloat cellHeight;




@end
