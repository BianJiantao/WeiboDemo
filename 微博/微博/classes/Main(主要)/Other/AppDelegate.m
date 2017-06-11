//
//  AppDelegate.m
//  微博
//
//  Created by BJT on 17/5/13.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "AppDelegate.h"
#import "WBTabbarController.h"
#import "WBNewFeatureController.h"
#import "WBOAuthController.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "SDWebImageManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // iOS8需要添加请求用户的授权
      if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
           UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
         [application registerUserNotificationSettings:settings];
     }
    
    
    // 1. create window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // 2. set window's rootViewController
    
    // get account model from sandBox
     WBAccount *account = [WBAccountTool account];
    if (account) {
        
        [self.window switchRootViewController];
        
    }else{
        
        self.window.rootViewController = [[WBOAuthController alloc] init];
    }
     

    // 3. set keyWindow and visible
    [self.window makeKeyAndVisible];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // run in background
    __block UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        // background task finished
        [application endBackgroundTask:ID];
    }];
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    
    // cancel download
    [mgr cancelAll];
    
    // clear cache
    [mgr.imageCache clearMemory];
    
}




@end
