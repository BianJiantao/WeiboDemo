//
//  WBStatus.h
//  微博
//
//  Created by BJT on 17/5/20.
//  Copyright © 2017年 BJT. All rights reserved.
// status model

#import <Foundation/Foundation.h>

@class WBUser;

@interface WBStatus : NSObject
/** 字符串型的微博ID */
@property (nonatomic,copy) NSString *idstr;

/** 微博信息内容 */
@property (nonatomic,copy) NSString *text;
/** 微博正文带属性文本(图文混排) */
@property (nonatomic,copy) NSAttributedString *attributedText;

/** 微博作者的用户模型  */
@property (nonatomic,strong) WBUser *user;

/** 微博创建时间 */
@property (nonatomic,copy) NSString *created_at;
/** 微博来源 */
@property (nonatomic,copy) NSString *source;

/** 微博配图 status pictures */
@property (nonatomic,strong) NSArray *pic_urls;

/** 被转发的微博 retweeted status */
@property (nonatomic,strong) WBStatus *retweeted_status;
/** 被转发微博正文带属性文本(图文混排) */
@property (nonatomic,copy) NSAttributedString *retweetedAttributedText;

/** 转发数 repost count */
@property (nonatomic,assign) int reposts_count;
/** 评论数 comments count */
@property (nonatomic,assign) int comments_count;
/** 点赞数 like count */
@property (nonatomic,assign) int attitudes_count;



///**
// *  create status model with status dictionary
// *
// *  @param dict status dictionary
// *
// *  @return status model
// */
//+(instancetype)statusWithDict:(NSDictionary *)dict;

@end
