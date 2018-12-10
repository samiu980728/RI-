//
//  ZRBCoordinateMananger.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCoordinateMananger.h"
#import "ZRBRequestJSONModel.h"
@interface ZRBCoordinateMananger()

@property (atomic, strong) NSMutableArray * dataMutArray;
@property (nonatomic, copy) __block NSString * lateseDate;
@property (nonatomic, strong) NSLock * lock;

@end

@implementation ZRBCoordinateMananger
static ZRBCoordinateMananger * manager = nil;

//单例创建仅仅执行一次 随时取用相关方法
+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.lock = [[NSLock alloc] init];
        manager.dataMutArray = [[NSMutableArray alloc] init];
    });
    return manager;
}

- (void)requestNewDateSucceed:(ZRBGetNewJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock
{
    _getIdMutArray = [[NSMutableArray alloc] init];
    ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
    NSString * testUrlStr = @"https://news-at.zhihu.com/api/4/news/latest";
    testUrlStr = [testUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * testUrl = [NSURL URLWithString:testUrlStr];
    NSURLRequest * testRequest = [NSURLRequest requestWithURL:testUrl];
    NSURLSession * testSession = [NSURLSession sharedSession];
    NSURLSessionDataTask * testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if ( error == nil ){
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            TotalJSONModel * model = [[TotalJSONModel alloc] initWithDictionary:dic error:nil];
            
//            for (int i = 0; i < model.stories.count; i++) {
//                [_getIdMutArray addObject:dic[@"stories"][i][@"id"]];
//            }
            succeedBlock(model);
        }else{
            if ( error ){
                NSLog(@"无法获取网路请求");
                errorBlock(error);
            }
        }
    }];
    [testDataTask resume];
}

- (void)requestDate:(NSString *)dateStr Succeed:(ZRBGetNewJSONModelHandle)succeedBlock ErrBlock:(ErrorHandle)errorBlock
{
    
        NSString * testUrlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@",[NSString stringWithFormat:@"%@",dateStr]];
        testUrlStr = [testUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                        
        NSURL * testUrl = [NSURL URLWithString:testUrlStr];
                        
        NSURLRequest * testRequest = [NSURLRequest requestWithURL:testUrl];
    
        NSURLSession * testSession = [NSURLSession sharedSession];
                        
        NSURLSessionDataTask * testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if ( error == nil ){
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                TotalJSONModel * beforeOnecUponDataJSONModel = [[TotalJSONModel alloc] initWithDictionary:dict error:nil];
                succeedBlock(beforeOnecUponDataJSONModel);
            }else{
                if (error) {
                    errorBlock(error);
                }
            }
        }];
        [testDataTask resume];
    
        NSLog(@"一口气四个日期  _dateMutArra.count = %li",_dateMutArray.count);
        NSLog(@"一口气四个日期  _dateMutArray = %@",_dateMutArray);
    
}

- (void)fetchDataFromNetisReferesh:(BOOL)isRefresh Succeed:(ZRBNSArrayBlock)succeedBlock error:(ErrorHandle)errorBlock{
    if ( !isRefresh ){
        [self requestNewDateSucceed:^(TotalJSONModel *mainMessageJSONModel) {
            NSArray * maindata = [NSArray arrayWithObject:mainMessageJSONModel];
            NSArray * data = mainMessageJSONModel.stories;
            self.lateseDate = mainMessageJSONModel.date;
            NSLog(@"_lateseDate = %@",_lateseDate);
            succeedBlock(maindata);
        } error:[errorBlock copy]];
    }else{
       __block NSInteger i = 0;
        NSLog(@"_lateseDate = %@",_lateseDate);
        
        [self requestDate:[NSString stringWithFormat:@"%ld",self.lateseDate.integerValue+1] Succeed:^(TotalJSONModel *mainMessageJSONModel) {
            [self.lock lock];
            if ( mainMessageJSONModel != nil ){
            [self.dataMutArray addObject:mainMessageJSONModel];
            }
            i++;
            if ( i == 5 ){
                NSLog(@"_dataMutArray = %@",_dataMutArray);
                ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
                [requestJSONModel.idMutArray setArray:_requestMutArray];
                
                [self dadadadSucceed:[succeedBlock copy]];
            }
            [self.lock unlock];
        } ErrBlock:[errorBlock copy]];
        
        [self requestDate:[NSString stringWithFormat:@"%ld",self.lateseDate.integerValue] Succeed:^(TotalJSONModel *mainMessageJSONModel) {
            [self.lock lock];
            //_lateseDate = @"20181130";
            if ( mainMessageJSONModel != nil ){
                [self.dataMutArray addObject:mainMessageJSONModel];
            }
            i++;
            if ( i == 5 ){
                NSLog(@"_dataMutArray = %@",_dataMutArray);
                ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
                [requestJSONModel.idMutArray setArray:_requestMutArray];
                [self dadadadSucceed:[succeedBlock copy]];
            }
            [self.lock unlock];
        } ErrBlock:[errorBlock copy]];
        
        
        
        [self requestDate:[NSString stringWithFormat:@"%ld",self.lateseDate.integerValue - 1] Succeed:^(TotalJSONModel *mainMessageJSONModel) {
                [self.lock lock];
                if ( mainMessageJSONModel != nil ){
                [_dataMutArray addObject:mainMessageJSONModel];
                }
                i++;
                if ( i == 5 ){
                    NSLog(@"_dataMutArray = %@",_dataMutArray);
                    ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
                    [requestJSONModel.idMutArray setArray:_requestMutArray];
                    
                    [self dadadadSucceed:[succeedBlock copy]];
                }
                [self.lock unlock];
            } ErrBlock:[errorBlock copy]];
        
        
            [self requestDate:[NSString stringWithFormat:@"%ld",self.lateseDate.integerValue - 2] Succeed:^(TotalJSONModel *mainMessageJSONModel) {
                [self.lock lock];
                if ( mainMessageJSONModel != nil ){
                [_dataMutArray addObject:mainMessageJSONModel];
                }
                i++;
                if ( i == 5 ){
                    NSLog(@"_dataMutArray = %@",_dataMutArray);
                    ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
                    [requestJSONModel.idMutArray setArray:_requestMutArray];
                    [self dadadadSucceed:[succeedBlock copy]];
                }
                [self.lock unlock];
            } ErrBlock:[errorBlock copy]];
   
        
            [self requestDate:[NSString stringWithFormat:@"%ld",self.lateseDate.integerValue - 3] Succeed:^(TotalJSONModel *mainMessageJSONModel) {
                [self.lock lock];
                if ( mainMessageJSONModel != nil ){
                [self.dataMutArray addObject:mainMessageJSONModel];
                }
                i++;
                if ( i == 5 ){
                    NSLog(@"_dataMutArray = %@",_dataMutArray);
                    ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
                    [requestJSONModel.idMutArray setArray:_requestMutArray];
                    [self dadadadSucceed:[succeedBlock copy]];
                }
                [self.lock unlock];
            } ErrBlock:[errorBlock copy]];
  
//            [self requestDate:[NSString stringWithFormat:@"%ld",self.lateseDate.integerValue] Succeed:^(TotalJSONModel *mainMessageJSONModel) {
//                [self.lock lock];
//                 _lateseDate = @"20181130";
//                if ( mainMessageJSONModel != nil ){
//                [self.dataMutArray addObject:mainMessageJSONModel];
//                }
//                i++;
//                if ( i == 5 ){
//                    NSLog(@"_dataMutArray = %@",_dataMutArray);
//                    ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
//                    [requestJSONModel.idMutArray setArray:_requestMutArray];
//                    [self dadadadSucceed:[succeedBlock copy]];
//                }
//                [self.lock unlock];
//            } ErrBlock:[errorBlock copy]];
        
    }
}

- (void)dadadadSucceed:(ZRBNSArrayBlock)succeedBlock{
    NSMutableArray * dateMutAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < _dataMutArray.count; i++) {
        TotalJSONModel * totalJSONModel = _dataMutArray[i];
        [dateMutAry addObject:totalJSONModel.date];
        NSLog(@"totalJSONModel.date = %@",totalJSONModel.date);
    }
    NSArray * sortArray = [dateMutAry sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSLog(@"obj1 = %@  obj2 = %@",obj1,obj2);
        if ( [obj1 integerValue] < [obj2 integerValue] ){
            return NSOrderedDescending;
        }
        else{
            return NSOrderedAscending;
        }
    }];
    NSMutableArray * returnArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < sortArray.count; j++) {
            for (int i = 0; i < _dataMutArray.count; i++){
                TotalJSONModel * totalJSONModel = _dataMutArray[i];
                if ( [totalJSONModel.date isEqualToString:[NSString stringWithFormat:@"%@",sortArray[j]]] ){
                    [returnArray addObject:totalJSONModel];
                }
            }
        }
    NSArray * realArray = [NSArray arrayWithArray:returnArray];
    NSLog(@"returnArray = %@",returnArray);
    succeedBlock(realArray);
    
}



@end
