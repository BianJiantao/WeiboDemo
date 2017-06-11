//
//  WBAccountTool.h
//  微博
//
//  Created by BJT on 17/5/19.
//  Copyright © 2017年 BJT. All rights reserved.
// 存储,读取  account 账号信息的工具类

#import <Foundation/Foundation.h>

@class WBAccount;

@interface WBAccountTool : NSObject

/**
 *  save account to sandBox
 *
 *  @param account account to save
 */
+ (void)saveAccount:(WBAccount *)account;

/**
 *  get account from sandBox
 *
 *  @return account (if account has  expired return nil )
 */
+ (WBAccount *)account;

@end
