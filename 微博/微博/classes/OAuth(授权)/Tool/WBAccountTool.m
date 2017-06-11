//
//  WBAccountTool.m
//  微博
//
//  Created by BJT on 17/5/19.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"

// sandBox path to store account model
#define kAccountSavePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation WBAccountTool

+(void)saveAccount:(WBAccount *)account
{
    // archive account to sandBox
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountSavePath];
}

+(WBAccount *)account
{
    // get account from sandBox
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountSavePath];
    
    // judge whether account has expired
    NSDate *now = [NSDate date];
    
    NSDate *created_time = account.created_time;
    long long expires_in = [account.expires_in longLongValue];
    NSDate *expires_time = [created_time dateByAddingTimeInterval:expires_in];
    
//    WBLog(@"%@,%@",expires_time,now);
    
    // expired when now >= expires_time
    NSComparisonResult result = [now compare:expires_time];
    if (result != NSOrderedAscending) { // expired
        return nil;
    }
    
    return  account;
}


@end
