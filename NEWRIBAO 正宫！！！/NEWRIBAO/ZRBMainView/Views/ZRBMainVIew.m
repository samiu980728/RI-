//
//  ZRBMainVIew.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMainVIew.h"
#import "ZRBLoadMoreView.h"
/************************自定义UIRefreshControl**************************/

//@interface WSRefreshControl : UIRefreshControl
//
//@end
//
//@implementation WSRefreshControl
//
//-(void)beginRefreshing
//{
//    [super beginRefreshing];
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//}
//
//-(void)endRefreshing
//{
//    [super endRefreshing];
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//}
//@end

/********************************************************************/

@implementation ZRBMainVIew

- (void)initMainTableView
{
    
    //测试 出现新的cell
    
    
    //代理网络传值
    _cellJSONModel = [[ZRBCellModel alloc] init];
    
    //得在调用代理前创建
    _titleMutArray = [[NSMutableArray alloc] init];
    
    _imageMutArray = [[NSMutableArray alloc] init];
    //代理得提前用
    //_cellJSONModel.delegateCell = self;
    
    //在这里解析数据
    
    _newsLabel = [[UILabel alloc] init];
    _newsImageView = [[UIImageView alloc] init];
    
    
    _analyJSONModel = [[ZRBAnalysisJSONModel alloc] init];
    
    //解析今日数据
    [_analyJSONModel AnalysisJSON];
    
    //解析昨天数据
    
    
    _analyJSONMutArray = [[NSMutableArray alloc] init];
    
    _navigationTextLabel = [[UILabel alloc] init];
    
    _leftNavigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _navigationTextLabel.text = @"今日新闻";
    
    _navigationTextLabel.font = [UIFont systemFontOfSize:15];
    _navigationTextLabel.textColor = [UIColor blackColor];
    
    [_leftNavigationButton setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    
    [self addSubview:_navigationTextLabel];
    [self addSubview:_leftNavigationButton];
    
    [_navigationTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(150);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    [_leftNavigationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@35);
    }];
    
    
    NSLog(@"----------------------");
    
    //ZRBCellModel 方法的调用
    [_cellJSONModel giveCellJSONModel];
    
    
    //在发送通知后
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    
    //创建另一个更新视图的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(giveMessageFromViewController:) name:@"reloadDataTongZhi" object:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _mainMessageTableView = [[UITableView alloc] init];
        [_mainMessageTableView registerClass:[ZRBNewsTableViewCell class] forCellReuseIdentifier:@"messageCell"];
        
        //注册头部视图
        [_mainMessageTableView registerClass:[ZRBDetailsTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"detailHeaderView"];
        
//        [_mainMessageTableView f]
        
        _mainMessageTableView.delegate = self;
        _mainMessageTableView.dataSource = self;
        
        //_cellJSONModel.delegateCell = self;
        
        [self setUpDownRefresh];
        
        [self addSubview:_mainMessageTableView];
        
        [_mainMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.top.equalTo(self).offset(50);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-30);
            
            
            _cellTagInteger = 0;
            
            //            make.edges.mas_equalTo(self);
        }];
        [_mainMessageTableView reloadData];
        
        
        
    });
    
}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tongzhi" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadDataTongZhi" object:nil];
}

////manager类网络请求
//- (void)fenethMessageFromManagerBlock
//{
//    [[ZRBCoordinateMananger sharedManager] fetchDataWithMainJSONModelsucceed:^(NSMutableArray *JSONModelMutArray) {
//        if ( [JSONModelMutArray isKindOfClass:[NSArray class]] && JSONModelMutArray.count > 0 ){
//            _analyJSONMutArray = [NSMutableArray arrayWithArray:JSONModelMutArray];
//        }
//        for ( int i = 0; i < _analyJSONMutArray.count; i++ ) {
//            ZRBMainJSONModel * titleModel = [[ZRBMainJSONModel alloc] init];
//            //StoriesJSONModel * storiesModel = [[StoriesJSONModel alloc] init];
//
//            titleModel = _analyJSONMutArray[i];
//            NSLog(@"-------titleModel---- == = %@--",_analyJSONMutArray[i]);
//
//            //为什么加不上去？？？？？
//            NSLog(@"titleModel.title === %@",titleModel.title);
//            [_titleMutArray addObject:titleModel.title];
//
//            NSLog(@"1232132132132132132132131");
//
//            //打印下来是【Images】 但是API分析里是image
//            //现在问题是 他把StoriesJSONModel 和 MainJSONModel  里的image弄混了
//            //一个是Images 一个是image
//
//
//            //NSString * JSONImageStr = [NSString stringWithFormat:@"%@",titleModel.images];
//
//            NSURL *JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",titleModel.images[0]]];
//
//            NSLog(@"titleModel.image === %@",titleModel.images);
//
//            NSLog(@"JSONImageStr == %@",JSONUrl);
//
//            NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
//            UIImage * image = [UIImage imageWithData:imageData];
//
//            if ( image ){
//                [_imageMutArray addObject:image];
//            }
//
//        }
//
//
//    } error:^(NSError *error) {
//        NSLog(@"网络请求出错-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
//    }];
//
//
//
//        //以上为刚才修改  ： 注释掉
//
////    [ZRBCoordinateMananger sharedManager] fetchDataWithMainJSONModel:^(NSMutableArray *obj) {
////        <#code#>
////    };
//}


- (void)tongzhi:(NSNotification *)noti
{
    //代理传值
    //ZRBMainVIew * mainVeiw = [[ZRBMainVIew alloc] init];
    
    //代理传值完毕 接下来就是 写ZRBCellModel代理在 该视图下的方法 并进行传值
    //在底下写 然后NSLog一下！！！！！！！！！
    //下面为赋值
    //    //以下为刚才修改 ： 注释掉
    if ( noti ){
    _analyJSONMutArray = [NSMutableArray arrayWithArray:noti.userInfo[@"one"]];
    }
//
//
//    for ( int i = 0; i < _analyJSONMutArray.count; i++ ) {
//        ZRBMainJSONModel * titleModel = [[ZRBMainJSONModel alloc] init];
//        //StoriesJSONModel * storiesModel = [[StoriesJSONModel alloc] init];
//
//        titleModel = _analyJSONMutArray[i];
//        NSLog(@"-------titleModel---- == = %@--",_analyJSONMutArray[i]);
//
//        //为什么加不上去？？？？？
//        NSLog(@"titleModel.title === %@",titleModel.title);
//        [_titleMutArray addObject:titleModel.title];
//
//        NSLog(@"1232132132132132132132131");
//
//        //打印下来是【Images】 但是API分析里是image
//        //现在问题是 他把StoriesJSONModel 和 MainJSONModel  里的image弄混了
//        //一个是Images 一个是image
//
//
//        //NSString * JSONImageStr = [NSString stringWithFormat:@"%@",titleModel.images];
//
//        NSURL *JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",titleModel.images[0]]];
//
//        NSLog(@"titleModel.image === %@",titleModel.images);
//
//        NSLog(@"JSONImageStr == %@",JSONUrl);
//
//        NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
//        UIImage * image = [UIImage imageWithData:imageData];
//
//        if ( image ){
//            [_imageMutArray addObject:image];
//        }
//
//    }
    //以上为刚才修改  ： 注释掉
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mainMessageTableView reloadData];
        _mainMessageTableView.tableFooterView.hidden = YES;
    });
    
}

//集成上拉刷新的方法

//这个 好像没有 用到？？？？
//这个写在COntroller里？？？？
- (void)setUpDownRefresh
{
    ZRBLoadMoreView * loadMoreView = [[ZRBLoadMoreView alloc] init];
    [loadMoreView footer];
    loadMoreView.frame = CGRectMake(0, 0, 414, 44);
    
    loadMoreView.hidden = YES;
    _mainMessageTableView.tableFooterView = loadMoreView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 100;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    ZRBLoadMoreView * loadMoreView = [[ZRBLoadMoreView alloc] init];
//    [loadMoreView footer];
//    loadMoreView.frame = CGRectMake(0, 0, 414, 44);
//
//    loadMoreView.hidden = NO;
//    return loadMoreView;
//}

//- (void)giveCellJSONModelToMainView:(NSMutableArray *)imaMutArray andTitle:(NSMutableArray *)titMutArray
//{
////    _imageMutArray = [NSMutableArray ar
//    //[_imageMutArray setArray:imaMutArray];
//    //[_imageMutArray addObject:imaMutArray];
//    //[_imageMutArray arrayByAddingObjectsFromArray:imaMutArray];
//   // [_titleMutArray setArray:titMutArray];
//
////    NSLog(@"****************    imaMutArray = == = = =%@",imaMutArray);
////    NSLog(@"****************代理协议里的  _imageMutArray = == = = = = == = %@",_imageMutArray);
//}

//- (void)refresh
//{
//
//    if (self.refreshControl.isRefreshing && self.loadMoreView.isAnimating ==NO){
//        [self.modelArray removeAllObjects];//清除旧数据，每次都加载最新的数据
//        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
//        [self addData];
//        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
//        [self.tableView reloadData];
//        [self.refreshControl endRefreshing];
//        self.loadMoreView.tipsLabel.hidden = YES;
//
//    }
//}
//
//- (void)loadMore
//{
//
//}
//
////加载数据
//- (void)addData
//{
//
//}

//头视图相关
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    _headerFooterView = [[ZRBDetailsTableViewHeaderFooterView alloc] init];
    _headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"detailHeaderView"];
    if ( _headerFooterView == nil ){
        _headerFooterView = [[ZRBDetailsTableViewHeaderFooterView alloc] initWithReuseIdentifier:@"detailHeaderView"];
        
        
    }
    _headerFooterView.dateLabel.text = @"每天都是星期七";
    NSLog(@"section == = == = = = %li",section);
    return _headerFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if ( _analyJSONMutArray.count <= 1 ){
//        return 1;
//    }
    
    NSLog(@"_analyJSONMutArray.count == == = = =%li = = == ",_analyJSONMutArray.count);
    return 100;
}

//在ZRBMainVIewController里面进行通知传值
- (void)giveMessageFromViewController:(NSNotification *)noti
{
    NSLog(@"12321312312312312312312312312312312312312312");
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mainMessageTableView reloadData];
    });
}



//- (UITableViewCell *)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"messageCell";
    NSString * CellIdentitier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    
    //在mainView的nagviationBar上加按钮！！！
    ZRBNewsTableViewCell * cell = nil;
    
    UITableViewCell * cell2 = nil;
    cell2 = [tableView dequeueReusableCellWithIdentifier:@"labelCell"];
    //cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    
    //然后该加入那个刷新符号啦！！！！！
    
    
    
    //cell = [tableView dequeueReusableCellWithIdentifier:CellIdentitier forIndexPath:indexPath];
    
    //if ( cell == nil ){
        //cell = [[ZRBNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentitier];
    
//    if ( indexPath.section == 0 ){
//    cell.tag = indexPath.row;
//        _cellTagInteger++;
//    }else{
//        cell.tag = indexPath.row + _cellTagInteger;
//    }
//    NSLog(@"cellTagInteger == = = %li",_cellTagInteger);
//    NSLog(@"cell.tag == = = = = =%li",cell.tag);
    
    
    //NSLog(@"_titleMutArray.count = %li, _imageMutArray.count = %li ",_titleMutArray.count,_imageMutArray.count);
    
    //NSLog(@"CELlllllllll 里的 _titleMutArray == %@",_titleMutArray);
    //if ( cell == nil ){
        
        //cell = [[ZRBNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
    
//    if ( indexPath.section > 1 ){
//        [_titleMutArray removeAllObjects];
//        [_imageMutArray removeAllObjects];
//    }
    
    NSLog(@"_analyJSONMutArray = %@,\n_analyJSONMutArray.count = %li",_analyJSONMutArray,_analyJSONMutArray.count);
    
    NSLog(@"---=-=-=-=-==-=");
    
    NSLog(@"_imageMutArray == == = ==%@ = = =",_imageMutArray);
    //if ( indexPath.section <= 0 ){
    //if ( indexPath.row < _analyJSONMutArray.count && indexPath.section == 0 ){
    
    if ( [_titleMutArray isKindOfClass:[NSArray class]] && _titleMutArray.count > 0 ){
        //if ( cell.tag <= _titleMutArray.count ){
        cell.newsLabel.text = [NSString stringWithFormat:@"%@",_titleMutArray[0][indexPath.row]];
        //cell.newsLabel.text = [NSString stringWithFormat:@"%@",[_titleMutArray objectAtIndex:indexPath.row]];
            NSLog(@"111");
        //}
        // NSLog(@"[_titleMutArray objectAtIndex:indexPath.row] == %@",[_titleMutArray objectAtIndex:indexPath.row]);
        //[_titleMutArray removeAllObjects];
        
    }
    
    if ( [_imageMutArray isKindOfClass:[NSArray class]] && _imageMutArray.count > 0 ){
        //if ( cell.tag <= _imageMutArray.count ){
        cell.newsImageView.image = _imageMutArray[0][indexPath.row];
//        cell.newsImageView.image = _imageMutArray[indexPath.row];
       // }
        //[_imageMutArray removeAllObjects];
    }
        
        //NSLog(@"indexPath.section == = = == = == = =%li==-=-=",indexPath.section);
        return cell;
   // }
    
    //}
//    else{
//        if ( cell2 == nil ){
//            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"labelCell"];
//
//            NSLog(@"_testStr == = = = %@",_testStr);
//            if ( _testStr ){
//            UILabel * label = [[UILabel alloc] init];
//                label.text = @"你好，我是中国人";
//                label.font = [UIFont systemFontOfSize:20];
//                label.frame = CGRectMake(0, 0, 200, 40);
//                [cell2.contentView addSubview:label];
//            }
//
//        }
//        return cell2;
//    }
    
  //  }
    
    //[self addSubview:cell];
    //开始给每个单元格赋值
   // }
    
    
    //目前的一个重用解决方法  不用自定义cell 用系统的cell 解决重用问题  看睡前的最后一篇文章
    //最新添加到safari书签中的那个！
    
    
   // return cell2;
    
    //[tableView reloadData];
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( [_delegate respondsToSelector:@selector(pushToWKWebView)] ){
        [_delegate pushToWKWebView];
    }
    
    
    //[currentViewControlller presentViewController:secondMessageViewController animated:YES completion:nil];
    
    //    _mainWebView = [[mainWKWebView alloc] initWithFrame:self.frame];
    //
    //    [self addSubview:_mainWebView];
    //
    //        [_mainWebView createAndGetJSONModelWKWebView];
    
    
    
    //[_mainWebView recieveNotification];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //NSLog(@"_analyJSONMutArray.count === =   %li",_analyJSONMutArray.count);
    //注意 这个根据 数组的count数量决定
    NSLog(@"_analyJSONMutArray = %@",_analyJSONMutArray);
    
    //NSUInteger sectionNumInteger = [_imageMutArray count];

    NSLog(@"sizeof(_imageMutArray[section]) / sizeof(_imageMutArray[section][0]) = %li",sizeof(_imageMutArray[section][section]));
    
    NSLog(@"123321_imageMutArray = %@",_titleMutArray);
    
    
    //一个一个断点的打 找问题  哪里传值有错误！！！！
    
    
    
    
    
    
    
    
    
    
    
    return sizeof(_imageMutArray[section][section]);
    return sizeof(_imageMutArray[section]) / sizeof(_imageMutArray[section][0]);
//    return _analyJSONMutArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    ZRBCoordinateMananger * manager = [ZRBCoordinateMananger sharedManager];
    
    NSLog(@"manager.dateMutArray.count = %li",manager.dateMutArray.count);
    return manager.dateMutArray.count + 0;
    return 3;
}




- (UIViewController *)getCurrentVC
{
    UIViewController * result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if ( window.windowLevel != UIWindowLevelNormal ){
        NSArray * windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if ( tmpWin.windowLevel == UIWindowLevelNormal ){
                window = tmpWin;
                break;
            }
        }
    }
    UIView * frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ( [nextResponder isKindOfClass:[UIViewController class]] ){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return result;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

