//
//  ZRBSQLiteManager.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/16.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@interface ZRBSQLiteManager : NSObject

+ (instancetype)sharedManager;

//创建image数据库
- (void)createFMDBImageDataSourceWithSQLName:(NSString *)sqlName;

//传入数据给image数据库
- (void)insertImageMessages:(NSMutableArray *)imageUrlMutArray toSQL:(FMDatabase *)dataBase;

//删除image数据库中数据
- (void)deleteSQLImageDataWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr;

//打开image数据库
- (void)openSQLImageDataWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr andimageMutArray:(NSMutableArray *)imageMutArray;

//打印image数据库
- (void)printfSQLImageDataWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr;

@property (nonatomic, strong) FMDatabase * imageSqlDataBase;

@end
