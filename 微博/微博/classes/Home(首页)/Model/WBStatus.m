//
//  WBStatus.m
//  微博
//
//  Created by BJT on 17/5/20.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "MJExtension.h"
#import "RegexKitLite.h"

#import "WBPhoto.h"
#import "WBStatus.h"
#import "WBStatusTextSegment.h"
#import "WBEmotion.h"
#import "WBEmotionTool.h"
#import "WBUser.h"
#import "WBStatusSpecialText.h"

/** main text font size */
#define kWBStatusCellTextContentFont [UIFont systemFontOfSize:14]

/** retweet text font size */
#define kWBStatusCellRetweetTextContentFont [UIFont systemFontOfSize:13]

@implementation WBStatus

+(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[WBPhoto class]};
}


-(NSAttributedString *)attributedTextWithText:(NSString *)text font:(UIFont *)font
{
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z-\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    // 存储文本碎片
    NSMutableArray *textSegments = [NSMutableArray array];
    /* 遍历特殊文本碎片 */
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        //        WBLog(@"%@ -- %@",*capturedStrings,NSStringFromRange(*capturedRanges));
        WBStatusTextSegment *specialText = [[WBStatusTextSegment alloc] init];
        specialText.text = *capturedStrings;
        specialText.range = *capturedRanges;
        specialText.special = YES;
        
        if ([(*capturedStrings) hasPrefix:@"["] && [(*capturedStrings) hasSuffix:@"]"] ) {
            specialText.emotion = YES;
        }
        
        [textSegments addObject:specialText];
        
        
    }];
    /* 遍历普通文本碎片 */
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        WBStatusTextSegment *commonText = [[WBStatusTextSegment alloc] init];
        commonText.text = *capturedStrings;
        commonText.range = *capturedRanges;
        [textSegments addObject:commonText];
        
    }];
    
    // 对文本碎片, 按 location  升序排序
    [textSegments sortUsingComparator:^NSComparisonResult(WBStatusTextSegment *obj1, WBStatusTextSegment *obj2) {
        
        if (obj1.range.location > obj2.range.location) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
        
    }];
    
    //    WBLog(@"%@",textSegments);
    /* 存储特殊文本模型 */
    NSMutableArray *specials = [NSMutableArray array];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    // 对文本碎片进行拼接
    for (WBStatusTextSegment *textSegment in textSegments) {
        
        NSAttributedString *subStr = [[NSAttributedString alloc] init];
        if(textSegment.emotion){// 表情
            
            WBEmotion *emotion = [WBEmotionTool emotionWithChs:textSegment.text];
            if(emotion){ // 如果有对应表情,以附件形式拼接
                
                NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                attach.image = [UIImage imageNamed:emotion.png];
                attach.bounds = CGRectMake(0, -4, font.lineHeight, font.lineHeight);
                subStr = [NSAttributedString attributedStringWithAttachment:attach];
            }else{ // 没有找到对应表情,以文本形式拼接
                
                subStr = [[NSAttributedString alloc] initWithString:textSegment.text];
            }
            
        }else if (textSegment.special){ // 非表情特殊文本 (话题, @, url)
            
            NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor  blueColor] forKey:NSForegroundColorAttributeName];
            subStr = [[NSAttributedString alloc] initWithString:textSegment.text attributes:dict];
            
            WBStatusSpecialText *special = [[WBStatusSpecialText alloc] init];
            special.text = textSegment.text;
            special.range = NSMakeRange(attStr.length, special.text.length);
            [specials addObject:special];
            
        }else{ // 普通文本
            
            subStr = [[NSAttributedString alloc] initWithString:textSegment.text];
        }
        
        [attStr appendAttributedString:subStr];
        
    }
    
//    WBLog(@"%@",specials);
    // 借助 属性 传递特殊文本模型数组给 WBStatusTextView ,供其处理点击事件
    [attStr addAttribute:kWBStatusSpecialTextKey value:specials range:NSMakeRange(0, 1)];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attStr.length)];
    return attStr;
}

-(void)setText:(NSString *)text
{
    _text = [text copy];
    
    _attributedText = [self attributedTextWithText:text font:kWBStatusCellTextContentFont];
}

-(void)setRetweeted_status:(WBStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    NSString *retweetText = [NSString stringWithFormat:@"@%@ : %@",retweeted_status.user.name,retweeted_status.text];
    
    _retweetedAttributedText = [self attributedTextWithText:retweetText font:kWBStatusCellRetweetTextContentFont];
}


-(NSString *)created_at
{
    // Wed May 24 09:05:30 +0800 2017
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *create_Date = [fmt dateFromString:_created_at];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 比较 年/月/日/时/分/秒
    NSDateComponents *cmps = [calendar components:unit fromDate:create_Date toDate:now options:0];
    
//    WBLog(@"%@--%@",_created_at,create_Date);
    
    
    if ([create_Date isThisYear]) { // 今年
        
        if([create_Date isToday]){ // 今天
            
            if (cmps.hour >= 1) {
                
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
                
            }else if( cmps.minute >= 1 ){
                
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
                
            }else{  // in one minute
                
                return @"刚刚";
            }
            
        }else if([create_Date isYesterday]){ // 昨天
            
            fmt.dateFormat = @"昨天 HH:mm:ss";
            
            return [fmt stringFromDate:create_Date];
            
            
        }else{ // 昨天以前
            
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            
            return [fmt stringFromDate:create_Date];
        }
        
        
    }else{
        
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        return [fmt stringFromDate:create_Date];
    }
    
//    return _created_at;
}



-(void)setSource:(NSString *)source
{
    // source == <a href="http://app.weibo.com/t/feed/6vtZb0" rel="nofollow">微博 weibo.com</a>
    if (source.length){
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];
    }else{
        _source = @"来自新浪微博";
    }
    
}


//+(instancetype)statusWithDict:(NSDictionary *)dict
//{
//    WBStatus *status = [[self alloc] init];
//    status.idstr = dict[@"idstr"];
//    status.text = dict[@"text"];
//    status.user = [WBUser userWithDict:dict[@"user"]];
//    
//    return status;
//}

@end
