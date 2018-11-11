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
    
    _zeroSectionInteger = 0;
    _nowIndexPathRowInteger = 0;
    _nowIndexPathSectionInteger = 0;
    _nowIndexPathAllPathAreaInteger = 0;
    _countRowInteger = 0;
    _imageCountInteger = 0;
    
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

- (void)tongzhi:(NSNotification *)noti
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[_mainMessageTableView reloadData];
        _mainMessageTableView.tableFooterView.hidden = YES;
    });
    
}

//集成上拉刷新的方法
- (void)setUpDownRefresh
{
    ZRBLoadMoreView * loadMoreView = [[ZRBLoadMoreView alloc] init];
    [loadMoreView footer];
    loadMoreView.frame = CGRectMake(0, 0, 414, 44);
    
    loadMoreView.hidden = YES;
    _mainMessageTableView.tableFooterView = loadMoreView;
}

//头视图相关
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
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
    NSLog(@"_analyJSONMutArray.count == == = = =%li = = == ",_analyJSONMutArray.count);
    return 100;
}

//在ZRBMainVIewController里面进行通知传值
- (void)giveMessageFromViewController:(NSNotification *)noti
{
    NSLog(@"12321312312312312312312312312312312312312312");
    
    NSLog(@"mainVIew _imageMutArray = %@",_imageMutArray);
    NSLog(@"mainVIew _titleMutArray = %@",_titleMutArray);

    
    static dispatch_once_t onceToken2;
    if ( _zeroSectionInteger == 1 ){
        dispatch_once(&onceToken2, ^{
            _countRowInteger = 0;
            _nowIndexPathRowInteger = 0;
            _imageCountInteger = 0;
        });
    }
    NSLog(@"_zeroSectionInteger = %li",_zeroSectionInteger);
    
    dispatch_async(dispatch_get_main_queue(), ^{
    [_mainMessageTableView reloadData];
        
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"messageCell";
    NSString * CellIdentitier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    ZRBNewsTableViewCell * cell = nil;
    
    UITableViewCell * cell2 = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    NSLog(@"indexPath.section = %li",indexPath.section);
    NSLog(@"indexPath.row = %li",indexPath.row);
    
    
    NSLog(@"_analyJSONMutArray = %@,\n_analyJSONMutArray.count = %li",_analyJSONMutArray,_analyJSONMutArray.count);
    
    NSLog(@"---=-=-=-=-==-=");
    
    NSLog(@"_imageMutArray == == = ==%@ = = =",_imageMutArray);
    
#pragma mark
    
    if ( [_titleMutArray isKindOfClass:[NSArray class]] && _titleMutArray.count > 0 ){
        if ( indexPath.row > 0 ){
            _zeroSectionInteger = 1;
        cell.newsLabel.text = [NSString stringWithFormat:@"%@",_titleMutArray[0]];
            [_titleMutArray removeObjectAtIndex:0];
        }
        
    }
    
    if ( [_imageMutArray isKindOfClass:[NSArray class]] && _imageMutArray.count > 0 ){
        //if ( cell.tag <= _imageMutArray.count ){
        
        if ( indexPath.row > 0 ){
            
        cell.newsImageView.image = _imageMutArray[0];
            [_imageMutArray removeObjectAtIndex:0];
        }
    }
        return cell;
   
}

- (void)changeNum
{
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( [_delegate respondsToSelector:@selector(pushToWKWebView)] ){
        [_delegate pushToWKWebView];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRow = 0;
    NSInteger numSection = 0;
    NSLog(@"_analyJSONMutArray = %@",_analyJSONMutArray);
    NSLog(@"numSection = %li",numSection);
    NSLog(@"numRow = %li",numRow);
    
    NSLog(@"222_imageMutArray[section] = = %li",sizeof(_imageMutArray[section]));
    NSLog(@"2221sizeof(_titleMutArray[section] = %li",sizeof(_titleMutArray[section]));
    NSLog(@"111_titleMutArray.count = %li",_titleMutArray.count);
    
    NSLog(@"123321_imageMutArray = %@",_titleMutArray);
    NSLog(@"_countRowInteger = %li",_countRowInteger);
    
    NSLog(@"_imageCountInteger = %li",_imageCountInteger);
    
    if ( _countRowInteger == 0 && _imageMutArray.count > _imageCountInteger ){
        
        _nowIndexPathRowInteger = _imageMutArray.count;
        NSLog(@"image count = %li, section = %li",_imageMutArray.count,section);
        _imageCountInteger = _imageMutArray.count;
        
        _countRowInteger++;
    }
    if ( _countRowInteger == 1 && _imageMutArray.count > _imageCountInteger ){
        _nowIndexPathRowInteger = _imageMutArray.count - _nowIndexPathRowInteger;
        NSLog(@"image count = %li, section = %li",_imageMutArray.count,section);
        _imageCountInteger = _imageMutArray.count;
        _countRowInteger++;
    }
    if ( _countRowInteger == 2 && _imageMutArray.count > _imageCountInteger ){
        _nowIndexPathRowInteger = _imageMutArray.count - _nowIndexPathRowInteger;
        NSLog(@"image count = %li, section = %li",_imageMutArray.count,section);
        _imageCountInteger = _imageMutArray.count;
        _countRowInteger++;
    }
    if ( _countRowInteger == 3 && _imageMutArray.count > _imageCountInteger ){
        _nowIndexPathRowInteger = _imageMutArray.count - _nowIndexPathRowInteger;
        NSLog(@"image count = %li, section = %li",_imageMutArray.count,section);
        _imageCountInteger = _imageMutArray.count;
        _countRowInteger++;
    }
    if ( _countRowInteger == 4 && _imageMutArray.count > _imageCountInteger ){
        _nowIndexPathRowInteger = _imageMutArray.count - _nowIndexPathRowInteger;
        NSLog(@"image count = %li, section = %li",_imageMutArray.count,section);
        _imageCountInteger = _imageMutArray.count;
        _countRowInteger++;
    }
    if ( _countRowInteger == 5 && _imageMutArray.count > _imageCountInteger ){
        _nowIndexPathRowInteger = _imageMutArray.count - _nowIndexPathRowInteger;
        NSLog(@"image count = %li, section = %li",_imageMutArray.count,section);
        _imageCountInteger = _imageMutArray.count;
        _countRowInteger++;
    }
    
    NSLog(@"_nowIndexPathRowInteger = %li",_nowIndexPathRowInteger);
    return _nowIndexPathRowInteger;
    return _imageMutArray.count;
    return sizeof(_imageMutArray[section]);
    return sizeof(_imageMutArray[section]) / sizeof(_imageMutArray[section][0]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    ZRBCoordinateMananger * manager = [ZRBCoordinateMananger sharedManager];
    
    NSLog(@"manager.dateMutArray.count = %li",manager.dateMutArray.count);
    return manager.dateMutArray.count + 0;
    return 4;
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

