//
//  ZRBSQLiteManager.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/16.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBSQLiteManager.h"

@implementation ZRBSQLiteManager
static ZRBSQLiteManager * manager = nil;
static FMDatabase * imageManagerSqlDataBase;
+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        imageManagerSqlDataBase = [[FMDatabase alloc] init];
    });
    return manager;
}

- (void)createFMDBImageDataSourceWithSQLName:(NSString *)sqlName
{
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * dbPath = [docsDir stringByAppendingPathComponent:sqlName];
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    _imageSqlDataBase = db;
    [db open];
    if ([db open]) {
        NSString * sql = @"CREATE TABLE 'JPXImageUrlUser' ('id' INTEGER PRIMARY KEY AUTOINCREMENAT NOT NULL , 'imageUrl' text)";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"错啦");
        } else {
            NSLog(@"对啦");
        }
        [db close];
    } else {
        NSLog(@"打不开呀");
    }
}

- (void)insertImageMessages:(NSMutableArray *)imageUrlMutArray toSQL:(FMDatabase *)dataBase
{
    [dataBase open];
    BOOL insertSQLImageResult = NO;
    NSError * error = nil;
    for (NSInteger i = 0; i < imageUrlMutArray.count; i++) {
        NSString * sql1 = @"insert into JPXImageUrlUser (imageUrl) values(?)";
        NSString * sql = @"insert into JPXImageUrlUser (imageUrl) values(?) ";
        NSLog(@"第%li次传值",i);
//        NSData * imageData = [NSJSONSerialization dataWithJSONObject:[NSURL URLWithString:imageUrlMutArray[i]] options:NSJSONWritingPrettyPrinted error:&error];
//        NSString * jsonStr = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
//        NSLog(@"jsonStr = %@  imageUrlMutArray = %@",jsonStr,imageUrlMutArray);
        
        NSString * imageStr = [NSString stringWithFormat:@"%@",imageUrlMutArray[i]];
        insertSQLImageResult = [dataBase executeUpdate:sql, imageStr];
//        insertSQLImageResult = [dataBase executeUpdate:sql, jsonStr];
        if (!insertSQLImageResult) {
            NSLog(@"传值失败");
        } else {
            NSLog(@"传值成功");
        }
    }
    [dataBase close];
}

//删除image数据库
- (void)deleteSQLImageDataWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr
{
    if ([dataBase open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",tableNameStr];
        BOOL res = [dataBase executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to deleta db data");
        }
        [dataBase close];
    }
}

//打开数据库
- (void)openSQLImageDataWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr andimageMutArray:(NSMutableArray *)imageMutArray
{
    if ([dataBase open]) {
        FMResultSet * getRes = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableNameStr]];
        if ([imageMutArray isKindOfClass:[NSArray class]] && imageMutArray.count == 0) {
            while ([getRes next]) {
                NSString * imageUrlStr = [NSString stringWithFormat:@"%@",[getRes stringForColumnIndex:1]];
                NSString * newimage1 = [imageUrlStr stringByReplacingOccurrencesOfString:@"[" withString:@""];
                NSString * newimage2 = [newimage1 stringByReplacingOccurrencesOfString:@"]" withString:@""];
                NSString * newimage3 = [newimage2 stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSString * newimage4 = [newimage3 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSString * newimage5 = [newimage4 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                [imageMutArray addObject:newimage5];
            }
        }
        [dataBase close];
    }
#pragma mark  注意还要更新主视图！！！！！！！！！！！！！
    
}


@end
