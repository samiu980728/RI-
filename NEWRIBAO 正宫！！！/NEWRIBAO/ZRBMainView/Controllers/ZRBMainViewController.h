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

#import "ZRBCoordinateMananger.h"

@interface ZRBMainViewController : UIViewController
<ZRBPushToWebViewDelegate,UITableViewDelegate,ZRBGiveCellJSONMOdelToMainViewDelegate>

@property (nonatomic, strong) ZRBMainVIew * MainView;

@property (nonatomic, assign) NSInteger iNum;

@property (nonatomic, strong) ZRBMyMessageViewController * viewController;

@property (nonatomic, strong) ZRBMessageVView * messageView;

@property (nonatomic, strong) ZRBMainWKWebView * mainWebView;

//网络请求需要用到的
@property (nonatomic, strong) NSMutableArray * mainTitleMutArray;

@property (nonatomic, strong) NSMutableArray * mainImageMutArray;

@property (nonatomic, strong) NSMutableArray * mainAnalyisMutArray;

@property (nonatomic, strong) ZRBCellModel * mainCellJSONModel;

//新方法调用Manager类里面的块去回调网络请求
- (void)fenethMessageFromManagerBlock;

@property (nonatomic, strong) NSMutableArray * titleMutArray;

@property (nonatomic, strong) NSMutableArray * imageMutArray;

@property (nonatomic, strong) NSMutableArray * analyJSONMutArray;

@property (nonatomic, assign) BOOL refresh;

@property (nonatomic, assign) NSInteger refreshNumInteger;

@end
