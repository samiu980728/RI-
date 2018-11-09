//
//  ZRBMainVIew.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBAnalysisJSONModel.h"
#import "ZRBNewsTableViewCell.h"
#import "ZRBMainWKWebView.h"
#import "SecondaryMessageViewController.h"
#import <Masonry.h>
#import "ZRBMainJSONModel.h"
#import "ZRBDetailsTableViewHeaderFooterView.h"
#import "ZRBLoadMoreView.h"
#import "ZRBCellModel.h"
#import "ZRBCoordinateMananger.h"

@protocol ZRBPushToWebViewDelegate <NSObject>

- (void)pushToWKWebView;

@end

@interface ZRBMainVIew : UIView

<UITableViewDelegate, UITableViewDataSource,ZRBGiveCellJSONMOdelToMainViewDelegate>

//测试 加载更多效果
@property (nonatomic, copy) NSString * testStr;


//mainTableView
@property (nonatomic, strong) UITableView * mainMessageTableView;

//解析JSON数据要用到的数组
@property (nonatomic, strong) NSMutableArray * analyJSONMutArray;

@property (nonatomic, strong) ZRBAnalysisJSONModel * analyJSONModel;

@property (nonatomic, strong) UILabel * navigationTextLabel;

@property (nonatomic, strong) UIButton * leftNavigationButton;

@property (nonatomic, strong) NSDictionary * analyJSONDict;
//每个cell要用到的label 与 button
@property (nonatomic, strong) UILabel * newsLabel;

@property (nonatomic, strong) UIImageView * newsImageView;

@property (nonatomic, strong) NSMutableArray * titleMutArray;

@property (nonatomic, strong) NSMutableArray * imageMutArray;


//设置代理
@property (nonatomic, weak) id <ZRBPushToWebViewDelegate> delegate;

//创建每个cell的推送显示  一个label 一个image
@property (nonatomic, strong) ZRBNewsTableViewCell * newsTableViewCell;
//创建主页面各个信息
//注意cell 的数量由JSONModelMut.count的数量决定
- (void)initMainTableView;

//创建顶部导航栏
- (void)initNavigationController;

//获取当前屏幕显示的ViewController
- (UIViewController *)getCurrentVC;

//创建cell点击后的跳转页面
@property (nonatomic, strong) ZRBMainWKWebView * mainWebView;

//设置头视图
@property (nonatomic, strong) ZRBDetailsTableViewHeaderFooterView * headerFooterView;

//加载更多视图
@property (nonatomic, strong) ZRBLoadMoreView * loadMoreView;
@property (nonatomic, strong) NSMutableArray * modelArray;
@property (nonatomic, assign) NSInteger cellTagInteger;

//ZRBCellModel代理
@property (nonatomic, strong) ZRBCellModel * cellJSONModel;
//@property (nonatomic, weak) id <ZRBGiveJSONModelMessageToViewDelegate> JSONModelDelegate;

//异步请求数据的方法


//集成上拉刷新的方法
- (void)setUpDownRefresh;

//新方法调用Manager类里面的块去回调网络请求
//- (void)fenethMessageFromManagerBlock;
//@property (nonatomic, strong)

@end

