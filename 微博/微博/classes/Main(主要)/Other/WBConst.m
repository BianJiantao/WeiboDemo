//
//  WBConst.m
//  微博
//
//  Created by BJT on 17/6/4.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <Foundation/Foundation.h>


/* 账号信息 */
NSString *const WBAppKey = @"1073508449";
NSString *const WBAppSecret = @"b73b9c801631be81412e904cb5e4287d";
NSString *const WBAppRedirectUri = @"http://www.baidu.com";


/* 发微博页面相关常量 */
// 选中表情的通知
NSString  *const WBEmotionDidSelectNotification = @"WBEmotionDidSelectNotification";
// 选中表情的 key
NSString  *const WBEmotionDidSelectKey= @"WBEmotionDidSelectKey";
// 点击删除按钮的通知
NSString  *const WBEmotionDidDeleteNotification = @"WBEmotionDidDeleteNotification";