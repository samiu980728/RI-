//
//  ZRBCoordinateMananger.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCoordinateMananger.h"


@implementation ZRBCoordinateMananger
static ZRBCoordinateMananger * manager = nil;

//单例创建仅仅执行一次 随时取用相关方法
+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)fetchDataWithMainJSONModelsucceed:(ZRBGetJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock
{
    dispatch_queue_t queue = dispatch_queue_create("ZRB.judge.queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"_ifAdoultRefreshStr 这里面的 = == = = == = = = %@",_ifAdoultRefreshStr);
    
    if ( _ifAdoultRefreshStr ){
        NSLog(@"成功调用之前的信息====-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
        __block NSInteger j = 4;
#pragma mark
        //这有问题 第一个日期在下面进行网络请求 所以应该从1 开始  错啦 就得从0开始
        __block NSInteger i = 0;
        //同步执行串行任务
        dispatch_queue_t serialQueue = dispatch_queue_create("oneQueue", DISPATCH_QUEUE_SERIAL);
        
        static dispatch_once_t onceToken2;
        
        
        //下面这个获取日期的函数 也是只执行一次
        dispatch_once(&onceToken2, ^{
            while (i < j) {
                //dispatch_sync(serialQueue, ^{
                NSLog(@"每次循环中的_dateMutArray = %@",_dateMutArray);
                if ( _dateMutArray.count-1 == i )
                    if ( _dateMutArray[i] ){
                        _testUrlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@",[NSString stringWithFormat:@"%@",_dateMutArray[i]]];
                        _testUrlStr = [_testUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                        
                        _testUrl = [NSURL URLWithString:_testUrlStr];
                        
                        _testRequest = [NSURLRequest requestWithURL:_testUrl];
                        
                        _nowDateStr = [[NSString alloc] init];
                        
                        _testSession = [NSURLSession sharedSession];
                        
                        _testDataTask = [_testSession dataTaskWithRequest:_testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                            if ( error == nil ){
                                _beforeObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                
                                _beforeOnecUponDataJSONModel = [[ZRBOnceUponDataJSONModel alloc] initWithDictionary:_beforeObj error:nil];
                                [_dateMutArray addObject:_beforeOnecUponDataJSONModel.date];
             
                            }else{
                                if (error) {
                                    errorBlock(error);
                                }
                            }
                        }];
                        [_testDataTask resume];
                        
                        i++;
                    }
            }
        });
        
        NSLog(@"一口气四个日期  _dateMutArra.count = %li",_dateMutArray.count);
        NSLog(@"一口气四个日期  _dateMutArray = %@",_dateMutArray);
        
        //创建串行队列
        dispatch_queue_t seriqlQueue1 = dispatch_queue_create("twoQueue", DISPATCH_QUEUE_SERIAL);
        
        __block NSInteger numFlag = 0;
        
        
        for (int i = 0; i < _dateMutArray.count; i++) {
            
            dispatch_async(seriqlQueue1, ^{
                
                NSMutableArray * _beforeJSONModelMut;
                _beforeJSONModelMut = [[NSMutableArray alloc] init];
                
                _testUrlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@",_dateMutArray[i]];
                NSLog(@"_testUrlStr = %@",_testUrlStr);
                
                _testUrlStr = [_testUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                _testUrl = [NSURL URLWithString:_testUrlStr];
                
                _testRequest = [NSURLRequest requestWithURL:_testUrl];
                
                _nowDateStr = [[NSString alloc] init];
                
                _testSession = [NSURLSession sharedSession];
                
                //继续复制下去
                
#pragma mark  在这里 传入网址 执行多次_testUrlStr 的赋值后 才会进行一次_tesdtDataTask 有问题
                _testDataTask = [_testSession dataTaskWithRequest:_testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if ( error == nil ){
                        numFlag++;
                        _beforeObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        
                        NSLog(@"_beforeObj[date] = == %@ ",_beforeObj);
                        
                        ZRBOnceUponDataJSONModel * _beforeOnecUponDataJSONModel;
                        
                        _beforeOnecUponDataJSONModel = [[ZRBOnceUponDataJSONModel alloc] initWithDictionary:_beforeObj error:nil];
                        
                        NSLog(@"_beforeOnecUponDataJSONModel = == = ==  %@",_beforeOnecUponDataJSONModel);
                        
                        _beforeDateStr = [NSString stringWithFormat:@"%@",_beforeOnecUponDataJSONModel.date];
                        
#pragma mark
                        NSLog(@"_dateMutArray.count ==  %li",_dateMutArray.count);
                        
                        NSLog(@"_dateMutArray = %@",_dateMutArray);
                        
                        NSLog(@"123for循环里面的_beforeDateStr = == =  %@",_beforeDateStr);
                        
                        NSLog(@"_beforeOnecUponDataJSONModel.stories.count === %li",_beforeOnecUponDataJSONModel.stories.count);
                        
                        for (int i = 0; i < _beforeOnecUponDataJSONModel.stories.count; i++) {
                            ZRBStoriesGoJSONModel * beforeStroiesGoJSONMOdel;
                            beforeStroiesGoJSONMOdel = [[ZRBStoriesGoJSONModel alloc] initWithDictionary:_beforeObj[@"stories"][i] error:nil];
                            NSLog(@"_beforeStoriesGoJSONModel == =  %@",beforeStroiesGoJSONMOdel);
                            
                            //这是一天的数据
                            if ( beforeStroiesGoJSONMOdel ){
                                //NSLog(@"_dateMutArray = %@",_dateMutArray[i]);
                                [_beforeJSONModelMut addObject:beforeStroiesGoJSONMOdel];
                            }
                        }
                        
                        
                        NSLog(@"for循环中 每次网络请求到的 _beforeJSONModelMut  = == = =   = = 9 09  %@",_beforeJSONModelMut);
                        succeedBlock(_beforeJSONModelMut);
                        
                    }else{
                        if ( error ){
                            errorBlock(error);
                        }
                    }
                }];
                //请求执行任务
                [_testDataTask resume];
                
                
            });
            
        }
    }
    
#pragma mark
    //以上是第二次上拉刷新执行的语句
    
        NSLog(@"继续调用原网络请求");
    
    static dispatch_once_t onceToken1;
    
    dispatch_once(&onceToken1, ^{
        _testUrlStr = @"https://news-at.zhihu.com/api/4/news/latest";
        
        //创建判断str
        _ifAdoultRefreshStr = [[NSString alloc] init];
        
        _testUrlStr = [_testUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        _testUrl = [NSURL URLWithString:_testUrlStr];
        
        _testRequest = [NSURLRequest requestWithURL:_testUrl];
        
        _nowDateStr = [[NSString alloc] init];
        
        _testSession = [NSURLSession sharedSession];
        _testDataTask = [_testSession dataTaskWithRequest:_testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if ( error == nil ){
                
                _obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSMutableArray * _JSONModelMut;
                
                _totalJSONModel = [[TotalJSONModel alloc] initWithDictionary:_obj error:nil];
                
                if ( !_JSONModelMut ){
                    _JSONModelMut = [[NSMutableArray alloc] init];
                }
                
                if ( !_dateMutArray ){
                    _dateMutArray = [[NSMutableArray alloc] init];
                }
                
                _beforeDateStr = [NSString stringWithFormat:@"%@",_totalJSONModel.date];
                
                if ( _dateMutArray.count == 0 ){
                    [_dateMutArray addObject:_beforeDateStr];
                    
                }
                NSLog(@"aaa_beforeDateStr = %@",_beforeDateStr);
                for (int i = 0; i < _totalJSONModel.stories.count; i++) {
                    StoriesJSONModel * _storiesJSONModel;
                    _storiesJSONModel = [[StoriesJSONModel alloc] initWithDictionary:_obj[@"stories"][i] error:nil];
                    if ( _storiesJSONModel ){
                        [_JSONModelMut addObject:_storiesJSONModel];
                    }
                }
                
                for (int i = 0; i < _totalJSONModel.top_stories.count; i++) {
                    ZRBMainJSONModel * _mainJSONModel;
                    _mainJSONModel = [[ZRBMainJSONModel alloc] initWithDictionary:_obj[@"top_stories"][i] error:nil];
                    if ( _mainJSONModel ){
                        [_JSONModelMut addObject:_mainJSONModel];
                    }
                }
                NSLog(@"块中的_JSONModelMut == = == %@",_JSONModelMut);
                
                
                succeedBlock(_JSONModelMut);
                
            }else{
                if ( error ){
                    errorBlock(error);
                }
            }
            
        }];
        [_testDataTask resume];
    });
    
}

@end
