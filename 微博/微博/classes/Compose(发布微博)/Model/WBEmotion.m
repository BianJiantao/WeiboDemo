//
//  WBEmotion.m
//  微博
//
//  Created by BJT on 17/5/29.
//  Copyright © 2017年 BJT. All rights reserved.
//  表情模型 emotion model

#import "WBEmotion.h"
#import "MJExtension.h"

@implementation WBEmotion

MJCodingImplementation

//-(instancetype)initWithCoder:(NSCoder *)decoder
//{
//    self = [super init];
//    if (self) {
//        self.chs = [decoder decodeObjectForKey:@"chs"];
//        self.png = [decoder decodeObjectForKey:@"png"];
//        self.code = [decoder decodeObjectForKey:@"code"];
//    }
//    return self;
//}
//
//-(void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.chs forKey:@"chs"];
//    [encoder encodeObject:self.png forKey:@"png"];
//    [encoder encodeObject:self.code forKey:@"code"];
//}

- (BOOL)isEqual:(WBEmotion *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}

@end
