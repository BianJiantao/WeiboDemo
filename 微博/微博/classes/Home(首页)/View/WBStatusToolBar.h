//
//  WBStatusToolBar.h
//  微博
//
//  Created by BJT on 17/5/23.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatus;

@interface WBStatusToolBar : UIView

@property (nonatomic,strong) WBStatus *status;

+(instancetype)toolBar;

@end
