//
//  WBDropDownMenu.h
//  微博
//
//  Created by BJT on 17/5/16.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBDropDownMenu;
@protocol WBDropDownMenuDelegate <NSObject>

@optional
/**
 *  dropDown Menu did dismiss
 *
 */
- (void)dropDownMenuDidDismiss:(WBDropDownMenu *)dropDownMenu;
/**
 *  dropDown Menu did show
 */
- (void)dropDownMenuDidShow:(WBDropDownMenu *)dropDownMenu;

@end

@interface WBDropDownMenu : UIView

@property (nonatomic,weak) id <WBDropDownMenuDelegate> delegate;

/**
 *  create dropdown Menu
 */
+ (instancetype)menu;


/**
 *  show the dropdown Menu from the clicked uivew
 *
 *  @param from  the clicked uivew
 */
- (void)showFrom:(UIView *)from;
/**
 *  dismiss the dropdown Menu
 */
- (void)dismiss;

/**
 *  content in the dropdownMenu's containerView
 */
@property (nonatomic,strong) UIView *content;
/**
 *  content controller
 */
@property (nonatomic,strong) UIViewController *contentVc;


@end
