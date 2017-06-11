//
//  NSDate+Extension.h
//  微博
//
//  Created by BJT on 17/5/24.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 * 判断某个时间是否是今年
 *  whether or not the date is this year
 */
-(BOOL)isThisYear;
/**
 * 判断某个时间是否是今天
 *  whether or not the date is today
 */
-(BOOL)isToday;
/**
 * 判断某个时间是否是昨天
 *  whether or not the date is yesterday
 */
-(BOOL)isYesterday;

@end
