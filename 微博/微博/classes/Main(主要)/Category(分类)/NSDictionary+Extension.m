//
//  NSDictionary+Extension.m
//  微博
//
//  Created by BJT on 17/5/20.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)
- (NSDictionary *)dictionaryByRemoveNULL {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    for (NSString *key in self) {
        id value = self[key];
        if ([value isKindOfClass:[NSNull class]]) {
            value = @"";
            WBLog(@"%@",key);
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            value = [value dictionaryByRemoveNULL];
        } else if ([value isKindOfClass:[NSArray class]]) {
            value = [value arrayByRemoveNULL];
        }
        [resultDict setObject:value forKey:key];
    }
    return resultDict;
}
@end
@implementation NSArray (Extension)

- (NSArray *)arrayByRemoveNULL
{
    NSMutableArray *resultArr = [NSMutableArray array];
    for (id value in self) {
        id item = value;
        if ([item isKindOfClass:[NSNull class]]) {
            item = @"";
        } else if ([item isKindOfClass:[NSArray class]]) {
            item = [item arrayByRemoveNULL];
        } else if ([item isKindOfClass:[NSDictionary class]]) {
            item = [item dictionaryByRemoveNULL];
        }
        
        [resultArr addObject:item];
    }
    return resultArr;
}

@end