//
//  ZRBRequestJSONModel.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/30.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBRequestJSONModel.h"


@implementation ZRBRequestJSONModel

- (void)requestJSONModel
{
    NSString * testUrlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/9699382"];
    
    
    NSURL *testUrl = [NSURL URLWithString:testUrlStr];
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession *testSession = [NSURLSession sharedSession];
    NSURLSessionDataTask * testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ( error == nil ){
            _obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        _modelStr = [NSString stringWithFormat:@"%@",[_obj objectForKey:@"body"]];
        
        NSLog(@"_modelStr === ==== %@",_modelStr);
        
        
                NSDictionary * dict = [[NSDictionary alloc] initWithDictionary:_obj];
                NSNotification * dictNotification = [NSNotification notificationWithName:@"Dicttongzhi" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:dictNotification];
        
        NSNotification * dictNotification1 = [NSNotification notificationWithName:@"Dicttongzhi1" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:dictNotification1];
        
    }];
    
    [testDataTask resume];

}

@end
