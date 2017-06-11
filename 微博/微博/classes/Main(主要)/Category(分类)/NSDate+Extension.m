//
//  NSDate+Extension.m
//  微博
//
//  Created by BJT on 17/5/24.
//  Copyright © 2017年 BJT. All rights reserved.
// 判断某个时间是否是 今年,今天,昨天

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


/**
 * 判断某个时间是否是今年
 *  whether or not the date is this year
 */
-(BOOL)isThisYear
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *date_cmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *now_cmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return date_cmps.year == now_cmps.year;
}

/**
 * 判断某个时间是否是今天
 *  whether or not the date is today
 */
-(BOOL)isToday
{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}

/**
 * 判断某个时间是否是昨天
 *  whether or not the date is yesterday
 */
-(BOOL)isYesterday
{
   
    // date ==  2017-04-30 10:05:28 --> 2017-04-30 00:00:00
    // now == 2017-05-01 09:22:10 --> 2017-05-01 00:00:00
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2017-04-30
    NSString *nowStr = [fmt stringFromDate:now];
    // 2017-05-01
    NSString *dateStr = [fmt stringFromDate:self];
    
    // 2017-04-30 00:00:00
    now = [fmt dateFromString:nowStr];
    // 2017-05-01 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now
                                          options:0];
    
    return (cmps.year ==0) && (cmps.month == 0 ) && (cmps.day == 1) ;
}



@end
