//
//  WBStatusCacheTool.m
//  微博
//
//  Created by BJT on 17/6/9.
//  Copyright © 2017年 BJT. All rights reserved.
//

#import "WBStatusCacheTool.h"
#import "FMDB.h"


static FMDatabase *_db;
@implementation WBStatusCacheTool


+(void)initialize
{
    // 打开数据库
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"statuses.sqlite"];
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    // 创建表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL);"];
}


+(NSArray *)statusesFromCacheWithParameters:(NSDictionary *)parameters
{    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
    if (parameters[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;", parameters[@"since_id"]];
    } else if (parameters[@"max_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;", parameters[@"max_id"]];
    } else {
        sql = @"SELECT * FROM t_status ORDER BY idstr DESC LIMIT 20;";
    }
    
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:status];
    }
    return statuses;
}

+(void)saveStatusToCache:(NSArray *)statuses
{
    for (NSDictionary *status in statuses) {
       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdate:@"INSERT INTO t_status (status,idstr) values(?,?)",data,status[@"idstr"]];
    }
}

@end
