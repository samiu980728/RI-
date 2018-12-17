//
//  ZRBCollectionManager.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCollectionManager.h"


@implementation ZRBCollectionManager
static ZRBCollectionManager * manager = nil;
static NSMutableArray * collectionidMutArray = nil;
+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        collectionidMutArray = [[NSMutableArray alloc] init];
    });
    return manager;
}

- (void)fetchNewCollectionDataWithidString:(NSString *)idString Succeed:(ZRBGetLastestNewsDictionaryHandle)succeedBlock error:(ErrorHandle)errorBlock
{
    NSString * urlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/%@",idString];
    [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ( error == nil ){
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            ZRBCollectiionJSONModel * collectionJSONModel = [[ZRBCollectiionJSONModel alloc] initWithDictionary:dict error:nil];
            succeedBlock(dict);
        }else{
            if ( error ){
                errorBlock(error);
                NSLog(@"无法无天");
            }
        }
    }];
    [dataTask resume];
}

- (void)collectNewsWouldCollected:(NSString *)idString
{
    [collectionidMutArray addObject:idString];
    _collectionidMutArray = [[NSMutableArray alloc] init];
    _collectionidMutArray = [NSMutableArray arrayWithArray:collectionidMutArray];
}

- (void)fetchBeforeCollectionDataWithIdString:(NSString *)idString Succeed:(ZRBGetLastestNewsHandle)succeedBlock error:(ErrorHandle)errorBlock
{
    
}


@end
