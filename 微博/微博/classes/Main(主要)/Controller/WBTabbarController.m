//
//  WBTabbarController.m
//  微博
//
//  Created by BJT on 17/5/14.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBTabbarController.h"
#import "WBHomeController.h"
#import "WBMessageCenterController.h"
#import "WBDiscoverController.h"
#import "WBProfileController.h"
#import "WBNavigationController.h"
#import "WBTabbar.h"
#import "WBComposeViewController.h"

@interface WBTabbarController ()<WBTabbarDelegatee>

@end

@implementation WBTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. tabbar , set childControllers
    
    // HomeViewController
    WBHomeController *homeVc = [[WBHomeController alloc] init];
    [self addChildVc:homeVc WithTitle:@"首页" Image:@"tabbar_home" SelectedImage:@"tabbar_home_selected"];
    
    // MessageCenterViewController
    WBMessageCenterController *messageCenterVc = [[WBMessageCenterController alloc] init];
    [self addChildVc:messageCenterVc WithTitle:@"消息" Image:@"tabbar_message_center" SelectedImage:@"tabbar_message_center_selected"];
    
    // DiscoverViewController
    WBDiscoverController *discoverVc = [[WBDiscoverController alloc] init];
    [self addChildVc:discoverVc WithTitle:@"发现" Image:@"tabbar_discover" SelectedImage:@"tabbar_discover_selected"];
    
    // ProfileViewController
    WBProfileController *profileVc = [[WBProfileController alloc] init];
    [self addChildVc:profileVc WithTitle:@"我" Image:@"tabbar_profile" SelectedImage:@"tabbar_profile_selected"];
    
//    WBLog(@"%@",self.tabBar);
    // replace system's tabbar with WBTabbar
    WBTabbar *tabbar = [[WBTabbar alloc] init];
//    tabbar.delegate = self;
    [self setValue:tabbar forKeyPath:@"tabBar"];
//    WBLog(@"%@",self.tabBar);
    
//    WBLog(@"%@",self.tabBar.delegate);
}

#pragma mark - WBTabbarDelegatee Method
-(void)tabbarDidClickPlusButton:(WBTabbar *)tabbar
{
    WBComposeViewController *vc = [[WBComposeViewController alloc] init];
    
    WBNavigationController *composeVc = [[WBNavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:composeVc animated:YES completion:nil];
}


#pragma mark - add tabbarController's child controller
/**
 *  add tabbarController's child controller
 *
 *  @param childVc       child controller
 *  @param title         child controller's title
 *  @param image         child controller's image
 *  @param selectedImage  child controller's image when selected
 */
- (void)addChildVc:(UIViewController *)childVc WithTitle:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage
{

    // set childController's text
//    childVc.tabBarItem.title = title; // set tabBar title
//    childVc.navigationItem.title = title; // set navigationBar title
    childVc.title = title; // set tabBar title and navigationBar title at the same time
    
        // set childController's image
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVc.view.backgroundColor = kRandomColor;
    
    // set text color style
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = kRGBColor(123, 123, 123);
    NSMutableDictionary *selectTextAttribute = [NSMutableDictionary dictionary];
    selectTextAttribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttribute forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttribute forState:UIControlStateSelected];
    
    // create custom NavigationController with childVc ,as a new childController
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
