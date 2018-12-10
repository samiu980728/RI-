//
//  ZRBCommentManager.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/19.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCommentManager.h"


@implementation ZRBCommentManager
static ZRBCommentManager * manager = nil;
//定义第一个块 返回 6.新闻的额外信息
//返回的类型为：JSONModel类型 然后 在 mainWKWebView中 回调 获得点赞总数和评论总数
//在ZRBCommentController中也需要回调 获得长评论总数和短评论总数

//定义第二个块 返回 7.新闻对应长评论查看
//在ZRBCommentController中回调 获得评论作者 评论的内容 用户头像图片的地址等 直接一个JSONModel即可
//需要在该Controller中解析并显示的是 评论作者 评论的内容 用户头像图片地址 评论所获赞的数量
//评论时间 所回复的消息 原消息的内容 消息状态 被回复者 错误消息（非0为已删除状态时出现）

//定义第三个块 返回 8.新闻对应短评论查看
//格式与前同

//点击短评论按钮后视图上移

+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.lock = [[NSLock alloc] init];
    });
    return manager;
}

//短评论请求
- (void)fetchShortShortCommentsDataFromNewsWith:(NSString *)idString Succeed:(ZRBGetLongCommentJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock
{
    NSString * testUrlString = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments",idString];
    [testUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * testUrl = [NSURL URLWithString:testUrlString];
    NSURLRequest * testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession * testSession = [NSURLSession sharedSession];
    NSURLSessionDataTask * testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ( error == nil ){
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZRBLongCommentsJSONModel * shortCommentsJSONModel = [[ZRBLongCommentsJSONModel alloc] initWithDictionary:dict error:nil];
            NSString * str = [NSString stringWithFormat:@"%@",shortCommentsJSONModel.comments];
            NSLog(@"longCommentsJSONModel.comments = %@",shortCommentsJSONModel.comments);
            NSLog(@"longCommentsJSONModel.comments = %@",shortCommentsJSONModel.comments[0]);
            NSLog(@"keyyyy = %@",[shortCommentsJSONModel.comments valueForKey:@"author"]);
            
            succeedBlock(shortCommentsJSONModel);
        }else{
            errorBlock(error);
        }
    }];
    [testDataTask resume];
}

//长评论请求
- (void)fetchLongLongCommentsDataFromNewsViewWith:(NSString *)idString Succeed:(ZRBGetLongCommentJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock
{
    NSString * testUrlString = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments",idString];
    [testUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * testUrl = [NSURL URLWithString:testUrlString];
    NSURLRequest * testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession * testSession = [NSURLSession sharedSession];
    NSURLSessionDataTask * testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ( error == nil ){
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZRBLongCommentsJSONModel * longCommentsJSONModel = [[ZRBLongCommentsJSONModel alloc] initWithDictionary:dict error:nil];
            NSString * str = [NSString stringWithFormat:@"%@",longCommentsJSONModel.comments];
            NSLog(@"longCommentsJSONModel.comments = %@",longCommentsJSONModel.comments);
            NSLog(@"longCommentsJSONModel.comments = %@",longCommentsJSONModel.comments[0]);
            NSLog(@"keyyyy = %@",[longCommentsJSONModel.comments valueForKey:@"author"]);

            if ( [longCommentsJSONModel.comments valueForKey:@"reply_to"] ){
                NSLog(@"replyyyy = %@",[longCommentsJSONModel.comments valueForKey:@"reply_to"]);
            }
            
            succeedBlock(longCommentsJSONModel);
        }else{
            errorBlock(error);
        }
    }];
    [testDataTask resume];
}

//评论总数请求
- (void)fetchCommentsNumDataFormNewsViewWithIdString:(NSString *)idString Succeed:(ZRBGetAdditionalJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock
{
    NSString * tedtUrlString = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%@",idString];
    //转译网址
    tedtUrlString = [tedtUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * testUrl = [NSURL URLWithString:tedtUrlString];
    NSURLRequest * testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession * testSession = [NSURLSession sharedSession];
    NSURLSessionDataTask * testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ( error == nil ){
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZRBNewsAdditionalJSONModel * additionalJSONModel = [[ZRBNewsAdditionalJSONModel alloc] initWithDictionary:dict error:nil];
            succeedBlock(additionalJSONModel);
        }else{
            errorBlock(error);
        }
    }];
    [testDataTask resume];
    
}

@end
