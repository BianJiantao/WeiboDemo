//
//  WBNavigationController.m
//  微博
//
//  Created by BJT on 17/5/14.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBNavigationController.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController


+(void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttri = [NSMutableDictionary dictionary];
    textAttri[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAttri forState:UIControlStateNormal];
    
#warning Disabled 状态的 item 效果必须在相应的 view 显示前准备好,才能实现 enable 设置的效果,也就是enable要晚一些设置
    NSMutableDictionary *textAttriDis = [NSMutableDictionary dictionary];
    textAttriDis[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:textAttriDis forState:UIControlStateDisabled];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  rewrite this method to intercept viewController which will be pushed
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // not rootViewController
        // hides tabbar in bottom when pushed
        viewController.hidesBottomBarWhenPushed = YES;
        
        /*set navigationBar*/
        // set leftBarButtonItem
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted"];

        // set rightBarButtonItem
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted"];
        
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
