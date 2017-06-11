//
//  WBAccount.m
//  微博
//
//  Created by BJT on 17/5/18.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBAccount.h"


@implementation WBAccount

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.access_token = dict[@"access_token"];
        self.expires_in = dict[@"expires_in"];
        self.uid = dict[@"uid"];
        // set time when account is created    
        self.created_time = [NSDate date];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

// choose property to  archive
-(void)encodeWithCoder:(NSCoder *)Coder
{
    [Coder encodeObject:self.access_token forKey:@"access_token"];
    [Coder encodeObject:self.expires_in forKey:@"expires_in"];
    [Coder encodeObject:self.uid forKey:@"uid"];
    [Coder encodeObject:self.created_time forKey:@"created_time"];
    [Coder encodeObject:self.name forKey:@"name"];
}
// choose property to unarchive
-(instancetype)initWithCoder:(NSCoder *)Decoder
{
    if (self = [super init]) {
        
        self.access_token = [Decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [Decoder decodeObjectForKey:@"expires_in"];
        self.uid = [Decoder decodeObjectForKey:@"uid"];
        self.created_time = [Decoder decodeObjectForKey:@"created_time"];
        self.name = [Decoder decodeObjectForKey:@"name"];
    }
    return self;
}


@end
