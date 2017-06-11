//
//  WBUser.h
//  微博
//
//  Created by BJT on 17/5/20.
//  Copyright © 2017年 BJT. All rights reserved.
// user model

#import <Foundation/Foundation.h>

typedef enum {
    WBUserVerifiedTypeNone = -1, // 没有任何认证
    
    WBUserVerifiedPersonal = 0,  // 个人认证
    
    WBUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    WBUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    WBUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    WBUserVerifiedDaren = 220 // 微博达人
} WBUserVerifiedType;


@interface WBUser : NSObject
/**  字符串型的用户UID */
@property (nonatomic,copy) NSString *idstr;
/** 用户昵称 */
@property (nonatomic,copy) NSString *name;

/** 用户头像地址（中图），50×50像素 */
@property (nonatomic,copy) NSString *profile_image_url;

/** 会员类型 , > 2 为会员, 0：非会员，11：月付，12：年付，13：包月付，14:准会员，2：过期会员 */
@property (nonatomic,assign) int mbtype;

/**  取值范围是0-6，0：非会员，1-6：代表会员的六个等级 */
@property (nonatomic,assign) int mbrank;

/** 是否是会员 */
@property (nonatomic,assign,getter=isVip) BOOL vip;

/** 用户认证类型 */
@property (nonatomic,assign) WBUserVerifiedType verified_type;


//
///**
// *  create user model with user dictionary
// *
// *  @param dict user dictionary
// *
// *  @return user model
// */
//+(instancetype)userWithDict:(NSDictionary *)dict;

@end
