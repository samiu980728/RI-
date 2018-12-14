//
//  ZRBMainViewController.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBMainVIew.h"
#import "ZRBMyMessageViewController.h"
#import "ZRBMainWKWebView.h"
#import "ZRBMessageVView.h"
#import <Masonry.h>
#import "SecondaryMessageViewController.h"
#import "ZRBCellModel.h"
#import "ZRBMainJSONModel.h"
#import "ZRBDetailsTableViewHeaderFooterView.h"
#import "ZRBCoordinateMananger.h"
#import <FMDB.h>
@interface ZRBMainViewController : UIViewController
<ZRBPushToWebViewDelegate,UITableViewDelegate,ZRBGiveCellJSONMOdelToMainViewDelegate,UITableViewDataSource>

//创建全局变量的数据库名称 然后创建  给数据的时候 他不是要更新UITABLEVIew呢么  那么如果数据库里面有数据的话
//即使没有进行网络请求 那么也可以进行数据请求
@property (nonatomic, copy) NSString * tableName;

@property (nonatomic, strong) FMDatabase * sqlDataBase;

@property (nonatomic, assign) NSInteger ifNetRequestInteger;

@property (nonatomic, assign) NSInteger haveGetSQLDataInteger;

@property (nonatomic, strong) NSMutableArray * urlImageMutArray;

@property (nonatomic, strong) ZRBMainVIew * MainView;

@property (nonatomic, assign) NSInteger iNum;

@property (nonatomic, strong) ZRBMyMessageViewController * viewController;

@property (nonatomic, strong) ZRBMessageVView * messageView;

@property (nonatomic, strong) ZRBMainWKWebView * mainWebView;

//网络请求需要用到的
@property (nonatomic, strong) NSMutableArray * mainTitleMutArray1;

@property (nonatomic, strong) NSMutableArray * mainImageMutArray1;

@property (nonatomic, strong) NSMutableArray * mainAnalyisMutArray;

@property (nonatomic, strong) ZRBCellModel * mainCellJSONModel;

//新方法调用Manager类里面的块去回调网络请求
- (void)fenethMessageFromManagerBlock:(BOOL)isRefresh;

@property (nonatomic, strong) NSMutableArray * titleMutArray1;

@property (nonatomic, strong) NSMutableArray * imageMutArray1;

//专属id
@property (nonatomic, strong) NSMutableArray * idSelfMutArray;

@property (nonatomic, strong) NSMutableArray * analyJSONMutArray;

@property (nonatomic, assign) BOOL refresh;

@property (nonatomic, assign) NSInteger refreshNumInteger;

@property (nonatomic, strong) NSMutableArray * allDateMutArray;

@property (nonatomic, strong) ZRBDetailsTableViewHeaderFooterView * headerFooterView;

@property (nonatomic, strong) UIImageView * barImageView;

@property (nonatomic, copy) NSIndexPath * indexPath;

@end

