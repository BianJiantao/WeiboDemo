//
//  WBTabbar.h
//  微博
//
//  Created by BJT on 17/5/17.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTabbar;

@protocol WBTabbarDelegatee <UITabBarDelegate>

@optional
/**
 *  click plus button
 */
- (void)tabbarDidClickPlusButton:(WBTabbar *)tabbar;

@end

@interface WBTabbar : UITabBar
@property (nonatomic,weak) id <WBTabbarDelegatee> delegate;
@end
