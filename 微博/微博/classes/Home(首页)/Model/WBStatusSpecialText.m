//
//  WBStatusSpecialText.m
//  微博
//
//  Created by BJT on 17/6/6.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBStatusSpecialText.h"

@implementation WBStatusSpecialText

-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@:%p>{%@,%@,%@}",self.class,self,self.text,NSStringFromRange(self.range),self.rects];
}

@end
