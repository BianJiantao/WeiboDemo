//
//  WBLoadMoreFooter.m
//  微博
//
//  Created by BJT on 17/5/21.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBLoadMoreFooter.h"

@implementation WBLoadMoreFooter


+(instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WBLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
