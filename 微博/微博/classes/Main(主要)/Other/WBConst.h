//
//  WBConst.h
//  微博
//
//  Created by BJT on 17/6/4.
//  Copyright © 2017年 BJT. All rights reserved.
// 常量文件

#import <Foundation/Foundation.h>

/* 账号信息 */
extern NSString *const WBAppKey;
extern NSString *const WBAppSecret;
extern NSString *const WBAppRedirectUri;



/* 发微博页面相关常量 */
// 选中表情的通知
extern NSString  *const WBEmotionDidSelectNotification ;
// 选中表情的 key
extern NSString  *const WBEmotionDidSelectKey;
// 点击删除按钮的通知
extern NSString  *const WBEmotionDidDeleteNotification;