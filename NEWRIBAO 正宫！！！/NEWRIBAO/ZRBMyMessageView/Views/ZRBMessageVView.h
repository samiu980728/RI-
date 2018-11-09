//
//  ZRBMessageVView.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBAnalysisJSONModel.h"
#import <Masonry.h>
#import "ZRBMessageTableViewCell.h"

@interface ZRBMessageVView : UIView
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UIView * mainView;

@property (nonatomic, strong) UIButton * guideButton;

@property (nonatomic, strong) UIButton * scrollButton;

@property (nonatomic, strong) UIScrollView * messageScrollew;

@property (nonatomic, strong) UITableView * messageTableView;

//存储用户信息和 推送的cell的名称
@property (nonatomic, strong) NSMutableArray * momentMutArray;

@property (nonatomic, strong) NSMutableString * nameMutString;

@property (nonatomic, copy) NSString * homePageString;

@property (nonatomic, copy) NSString * collectionString;

@property (nonatomic, copy) NSString * setString;

//mainTableView
@property (nonatomic, strong) UITableView * mainMessageTableView;

//解析JSON数据要用到的数组
@property (nonatomic, strong) NSMutableArray * analyJSONMutArray;

@property (nonatomic, strong) ZRBAnalysisJSONModel * analyJSONModel;

- (void)initView;

- (void)initScrollView;

- (void)initTableView;

//创建主页面各个信息
//注意cell 的数量由JSONModelMut.count的数量决定
- (void)initMainTableView;
@end

