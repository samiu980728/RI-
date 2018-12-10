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
    
    _dateNowMutArray = [[NSMutableArray alloc] init];
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
    
    //[self addSubview:_navigationTextLabel];
    //[self addSubview:_leftNavigationButton];
    
    //ZRBCellModel 方法的调用
    [_cellJSONModel giveCellJSONModel];
    
    //在发送通知后
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    
    //创建另一个更新视图的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(giveMessageFromViewController:) name:@"reloadDataTongZhi" object:nil];
        _mainMessageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-30) style:UITableViewStylePlain];
//        _mainMessageTableView.style = UITableViewStyleGrouped;
        [self addSubview:_mainMessageTableView];
        
        [_mainMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.top.equalTo(self).offset(50);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-30);
            
            
            _cellTagInteger = 0;
        }];
}

//侧拉栏的展开和关闭


- (void)giveMessageFromViewController:(NSNotification *)noti
{
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
            //[_titleMutArray removeObjectAtIndex:0];
        }
        
    }
    
    if ( [_imageMutArray isKindOfClass:[NSArray class]] && _imageMutArray.count > 0 ){
        //if ( cell.tag <= _imageMutArray.count ){
        
        if ( indexPath.row > 0 ){
            
        cell.newsImageView.image = _imageMutArray[0];
            //[_imageMutArray removeObjectAtIndex:0];
        }
    }
        return cell;
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( [_delegate respondsToSelector:@selector(pushToWKWebView)] ){
        [_delegate pushToWKWebView];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imageMutArray.count;
    return sizeof(_imageMutArray[section]);
    return sizeof(_imageMutArray[section]) / sizeof(_imageMutArray[section][0]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dateNowMutArray.count;
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

