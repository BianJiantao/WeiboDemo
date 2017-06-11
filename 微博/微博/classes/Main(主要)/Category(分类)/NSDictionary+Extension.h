//
//  NSDictionary+Extension.h
//  微博
//
//  Created by BJT on 17/5/20.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

- (NSDictionary *)dictionaryByRemoveNULL;

@end

@interface NSArray (Extension)

- (NSArray *)arrayByRemoveNULL;

@end