//
//  WBUser.m
//  微博
//
//  Created by BJT on 17/5/20.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser

//+(instancetype)userWithDict:(NSDictionary *)dict
//{
//    WBUser *user = [[self alloc] init];
//    
//    user.idstr = dict[@"idstr"];
//    user.name = dict[@"name"];
//    user.profile_image_url = dict[@"profile_image_url"];
//    
//    return user;
//}


-(void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    //  mbtype > 2 为会员
    self.vip = mbtype > 2;
}

@end
