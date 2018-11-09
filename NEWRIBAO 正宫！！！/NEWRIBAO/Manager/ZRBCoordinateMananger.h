//
//  ZRBCoordinateMananger.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZRBMainJSONModel.h"
#import "ZRBOnceUponDataJSONModel.h"



typedef void(^ZRBGetJSONModelHandle)(NSMutableArray * JSONModelMutArray);

//请求失败回调block
typedef void(^ErrorHandle)(NSError *error);


@interface ZRBCoordinateMananger : NSObject


@property (nonatomic, copy) NSString * testUrlStr;

@property (nonatomic, strong) NSURL * testUrl;

@property (nonatomic, strong) NSURLRequest * testRequest;

@property (nonatomic, strong) NSURLSession * testSession;

@property (nonatomic, strong) NSURLSessionDataTask * testDataTask;

@property (nonatomic, strong) NSDictionary * obj;

@property (nonatomic, strong) NSMutableArray * JSONModelMut;

@property (nonatomic, copy) NSString * nowDateStr;

@property (nonatomic, strong) TotalJSONModel * totalJSONModel;

@property (nonatomic, strong) ZRBMainJSONModel * mainJSONModel;

@property (nonatomic, strong) StoriesJSONModel * storiesJSONModel;

@property (nonatomic, strong) NSMutableArray * testUrlMutArray;


//获取当前日期 为了
@property (nonatomic, copy) NSString * beforeDateStr;

//为了区别用户是否已经进行下拉刷新操作
@property (nonatomic, copy) NSString * ifAdoultRefreshStr;

//存储日期的数组
@property (nonatomic, strong) NSMutableArray * dateMutArray;

//存储往日各类消息的数组
@property (nonatomic, strong) NSMutableArray * beforeJSONModelMut;

@property (nonatomic, strong) ZRBOnceUponDataJSONModel * beforeOnecUponDataJSONModel;

@property (nonatomic, strong) ZRBStoriesGoJSONModel * beforeStoriesGoJSONModel;

//这个不需要
//@property (nonatomic, strong) StoriesJSONModel * beforeStoriesJSONModel;

@property (nonatomic, strong) NSDictionary * beforeObj;

+ (instancetype)sharedManager;

//@property (nonatomic, strong) ZRBCoordinateMananger * manager;

//导入网络请求
- (void)fetchDataWithMainJSONModelsucceed:(ZRBGetJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock;

@end
