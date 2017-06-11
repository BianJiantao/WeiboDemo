//
//  UIWindow+Extension.m
//  微博
//
//  Created by BJT on 17/5/19.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "WBTabbarController.h"
#import "WBNewFeatureController.h"

#define kVersionKey @"CFBundleVersion"

@implementation UIWindow (Extension)

-(void)switchRootViewController
{
    // judge the version
    
    // get last app version from sandBox
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kVersionKey];
    
    // get current app Version from Info.plist
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[kVersionKey];
    
    if ([currentVersion isEqualToString:lastVersion]) {// verison is the same
        
        self.rootViewController = [[WBTabbarController alloc] init];
        
    }else{// new version , display new feature
        
        self.rootViewController = [[WBNewFeatureController alloc] init];
        
        // store new version to sandBox
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

@end
