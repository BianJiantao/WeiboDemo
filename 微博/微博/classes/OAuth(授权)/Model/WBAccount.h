//
//  WBAccount.h
//  微博
//
//  Created by BJT on 17/5/18.
//  Copyright © 2017年 BJT. All rights reserved.
// 账号信息

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject<NSCoding>

/**
 *   access_token	string	用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据，第三方应用应该用该票据和自己应用内的用户建立唯一影射关系，来识别登录状态，不能使用本返回值里的UID字段来做登录识别。
 */
@property (nonatomic,copy) NSString *access_token;
/**
 *   expires_in	string	access_token的生命周期，单位是秒数。
 */
@property (nonatomic,copy) NSNumber *expires_in;
/**
 *   uid	string	授权用户的UID，本字段只是为了方便开发者，减少一次user/show接口调用而返回的，第三方应用不能用此字段作为用户登录状态的识别，只有access_token才是用户授权的唯一票据。
 */
@property (nonatomic,copy) NSString *uid;

/**
 *  user name
 */
@property (nonatomic,copy) NSString *name;

/**
 *  access_token's created time
 */
@property (nonatomic,strong) NSDate *created_time;

/**自定义构造方法，利用字典初始化模型*/
- (instancetype)initWithDict:(NSDictionary *)dict;
/**类方法，利用字典初始化模型*/
+ (instancetype)accountWithDict:(NSDictionary *)dict;



@end
