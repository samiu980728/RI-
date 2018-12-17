//
//  ZRBAnalysisJSONModel.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZRBMainJSONModel.h"

@interface ZRBAnalysisJSONModel : NSObject

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

//昨天
@property (nonatomic, copy) NSString * testUrlStr1;

@property (nonatomic, strong) NSURL * testUrl1;

@property (nonatomic, strong) NSURLRequest * testRequest1;

@property (nonatomic, strong) NSURLSession * testSession1;

@property (nonatomic, strong) NSURLSessionDataTask * testDataTask1;

@property (nonatomic, strong) NSDictionary * obj1;

@property (nonatomic, strong) NSMutableArray * JSONModelMut1;

- (void)AnalysisJSON;



@end

