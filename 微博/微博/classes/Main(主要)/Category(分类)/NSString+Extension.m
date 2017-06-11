//
//  NSString+Extension.m
//  微博
//
//  Created by BJT on 17/5/22.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(CGSize)sizeWithTextFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    CGSize size = CGSizeMake(maxWidth, MAXFLOAT);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    
    return  [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

-(CGSize)sizeWithTextFont:(UIFont *)font
{
    return  [self sizeWithTextFont:font maxWidth:MAXFLOAT];
}


-(NSInteger)fileSize
{
        NSFileManager *mgr = [NSFileManager defaultManager];
        // 判断是否为文件
        BOOL dir = NO;
        BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
        // 文件\文件夹不存在
        if (exists == NO) return 0;
        
        if (dir) { // self是一个文件夹
            // 遍历caches里面的所有内容 --- 直接和间接内容
            NSArray *subpaths = [mgr subpathsAtPath:self];
            NSInteger totalByteSize = 0;
            for (NSString *subpath in subpaths) {
                // 获得全路径
                NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
                // 判断是否为文件
                BOOL dir = NO;
                [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
                if (dir == NO) { // 文件
                    totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
                }
            }
            return totalByteSize;
        } else { // self是一个文件
            return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
        }
}

@end
