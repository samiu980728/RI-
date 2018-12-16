//
//  ZRBMainViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMainViewController.h"
#import "ZRBNewsTableViewCell.h"
#import "ZRBContinerViewController.h"
#import <UIImageView+WebCache.h>

@interface ZRBMainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, assign) NSInteger closeAndClickInteger;

@end

@implementation ZRBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _refreshNumInteger = 0;
    _closeAndClickInteger = 0;
    _ifNetRequestInteger = 0;
    _haveGetSQLDataInteger = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataTongZhiController:) name:@"reloadDataTongZhiController" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"今日新闻";
    
    _refresh = YES;
    _urlImageMutArray = [[NSMutableArray alloc] init];
    _idSelfMutArray = [[NSMutableArray alloc] init];
    _mainAnalyisMutArray = [[NSMutableArray alloc] init];
    _allDateMutArray = [[NSMutableArray alloc] init];
    _mainCellJSONModel = [[ZRBCellModel alloc] init];
    [_mainCellJSONModel giveCellJSONModel];
    _mainCellJSONModel.delegateCell = self;

    //开启滑动返回功能代码
    if ( [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(0, 900);
    _scrollView.delegate = self;
    _messageView = [[ZRBMessageVView alloc] init];
    [_messageView initTableView];
    _MainView = [[ZRBMainVIew alloc] init];
    [_MainView initMainTableView];
    
    self.title = @"今天新闻";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.navigationController.view.layer.shadowOpacity = 0.15;
    self.navigationController.view.layer.shadowRadius = 10;
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.png"]];
    
    UIBarButtonItem * menuItemm = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
    self.navigationItem.leftBarButtonItem = menuItemm;
    
    [_MainView.mainMessageTableView registerClass:[ZRBNewsTableViewCell class] forCellReuseIdentifier:@"messageCell"];
    [_MainView.mainMessageTableView registerClass:[ZRBDetailsTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"detailHeaderView"];
    _MainView.delegate = self;
    [_scrollView addSubview:_MainView];
    _MainView.mainMessageTableView.delegate = self;
    _MainView.mainMessageTableView.dataSource = self;
    [self.view addSubview:_scrollView];
    [self fenethMessageFromManagerBlock:NO];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _barImageView = [[UIImageView alloc] init];
    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
    
    //创建数据库
    _tableName = @"JPXUser";
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * dbPath = [docsdir stringByAppendingPathComponent:@"title.sqlite1"];
    //_sqlDataBase = [FMDatabase databaseWithPath:dbPath];\
    //开始弄数据库啦
    [self createFMDBDataSource];
    
    //创建image数据库
    _imageTableName = @"JPXImageUrlUser";
    NSString * sqlName = @"image.sqlite1";
    ZRBSQLiteManager * manager = [ZRBSQLiteManager sharedManager];
    
    //问题：这个数据库
    [manager createFMDBImageDataSourceWithSQLName:sqlName];
    
    _imageRealSQLDataBase = manager.imageSqlDataBase;
}

//侧边框栏的展开和关闭
- (void)openCloseMenu:(UIBarButtonItem *)sender
{
    _closeAndClickInteger++;
    NSLog(@"self.navigationController.parentViewController = %@",self.navigationController.parentViewController);
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}

//开始FMDB！！！！！
- (void)createFMDBDataSource
{
//    NSDocumentDirectory 是指程序中对应的Documents路径，
//    而NSDocumentionDirectory对应于程序中的Library/Documentation路径，这个路径是没有读写权限的，所以看不到文件生成。
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * dbPath = [docsdir stringByAppendingPathComponent:@"title.sqlite1"];
    FMDatabase * db = [FMDatabase databaseWithPath:dbPath];
    _sqlDataBase = db;
    [db open];
    if ([db open]) {
        NSString * sql = @"CREATE TABLE 'JPXUser' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , 'title' text)";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"错啦");
        } else {
            NSLog(@"对啦");
        }
        [db close];
    } else {
        NSLog(@"打不开呀");
    }
    
    //删除
    //[self deleteSQLDataWith:db andTableName:@"JPXUser"];
    
    //传入
    //[self insertMessages:_titleMutArray1 toSQL:db];
    
    //打印
    //[self printfSQLDataWith:db andTableName:@"JPXUser"];
}

//传入data 给数据库
- (void)insertMessages:(NSMutableArray *)titleMutArray toSQL:(FMDatabase *)dataBase
{
    [dataBase open];
    BOOL  insertSQLResult = NO;
    NSInteger  insertNum = 0;
    NSError * error = nil;
    
    for (NSInteger i = 0; i < titleMutArray.count; i++) {
        NSString * sql = @"insert into JPXUser (title) values(?) ";
        NSLog(@"第%li次传值",i);
        NSData * titleData = [NSJSONSerialization dataWithJSONObject:titleMutArray[i] options:NSJSONWritingPrettyPrinted error:&error];
        NSString * jsonStr = [[NSString alloc] initWithData:titleData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonStr = %@  titleMutArray = %@",jsonStr,titleMutArray);
        insertSQLResult = [dataBase executeUpdate:sql, jsonStr];
        if (!insertSQLResult) {
            NSLog(@"传值失败");
        } else {
            NSLog(@"传值成功");
        }
    }
    [dataBase close];
}

//删除数据库
- (void)deleteSQLDataWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr
{
    if ([dataBase open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",tableNameStr];
        BOOL res = [dataBase executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to deleta db data");
        }
        [dataBase close];
    }
}

//打开数据库
- (void)openSQLDataWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr
{
    if ([dataBase open]) {
        FMResultSet * getRes = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableNameStr]];
        if ([_titleMutArray1 isKindOfClass:[NSArray class]] &&_titleMutArray1.count == 0) {
        while ([getRes next]) {
            NSString * title = [NSString stringWithFormat:@"%@",[getRes stringForColumnIndex:1]];
            NSLog(@"title.length = %li",title.length);
            NSString * newTitle1 = [title stringByReplacingOccurrencesOfString:@"[" withString:@""];
            NSString * newTitle2 = [newTitle1 stringByReplacingOccurrencesOfString:@"]" withString:@""];
            NSString * newTitle3 = [newTitle2 stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString * newTitle4 = [newTitle3 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString * newTitle5 = [newTitle4 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            [_titleMutArray1 addObject:newTitle5];
        }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_MainView.mainMessageTableView reloadData];
            });
        }
        [dataBase close];
    }
}

//下一步：  储存图片路径！！！

//打印数据库
- (void)printfSQLDataWith:(FMDatabase *)dataBase andTableName:(NSString *)tableNameStr
{
    if ([dataBase open]) {
        FMResultSet * getRes = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tableNameStr]];
        while ([getRes next]) {
            NSInteger userId = [getRes intForColumnIndex:0];
            NSString * title = [getRes stringForColumnIndex:1];
            NSLog(@"title = %@ user id = %li",title,userId);
        }
        [dataBase close];
    }
}

//判断数据库中是否有内容，有的话 加载即可

//给这加个参数 BOOL 类型 判断是否上拉 传参数进行以下两种判断即可
- (void)fenethMessageFromManagerBlock:(BOOL)isRefresh
{
    _mainImageMutArray1 = [[NSMutableArray alloc] init];
    _mainTitleMutArray1 = [[NSMutableArray alloc] init];
    _titleMutArray1 = [[NSMutableArray alloc] init];
    _imageMutArray1 = [[NSMutableArray alloc] init];
    
    dispatch_queue_t queue = dispatch_queue_create("NetRequestQueue", DISPATCH_QUEUE_SERIAL);
   // dispatch_async(queue, ^{
//    });
    if ( isRefresh == NO ){
        [[ZRBCoordinateMananger sharedManager] fetchDataFromNetisReferesh:NO Succeed:^(NSArray *array) {
            _ifNetRequestInteger = 1;
            TotalJSONModel * totalJSONModel = array[0];
            [_allDateMutArray addObject:totalJSONModel.date];
            NSArray * data = totalJSONModel.stories;
            for (int i = 0; i < data.count; i++) {
                NSMutableArray * titleMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * imageMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * idMutArray = [[NSMutableArray alloc] init];
                StoriesJSONModel * storJSONModel = data[i];
                [titleMutArray addObject:storJSONModel.title];
                [idMutArray addObject:[NSNumber numberWithInteger:storJSONModel.id]];
                NSURL * JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",storJSONModel.images[0]]];
                NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
                UIImage * image = [UIImage imageWithData:imageData];
                if ( image ){
                    [imageMutArray addObject:image];
                }
                [_titleMutArray1 addObject:titleMutArray];
                [_imageMutArray1 addObject:imageMutArray];
                [_idSelfMutArray addObject:[NSNumber numberWithInteger:storJSONModel.id]];
                [_urlImageMutArray addObject:[NSURL URLWithString:[NSString stringWithFormat:@"%@",storJSONModel.images[0]]]];
            }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //[self createFMDBDataSource];
                            [self deleteSQLDataWith:_sqlDataBase andTableName:_tableName];
                            [self insertMessages:_titleMutArray1 toSQL:_sqlDataBase];
                            [self printfSQLDataWith:_sqlDataBase andTableName:_tableName];
                            
                            ZRBSQLiteManager * manager = [ZRBSQLiteManager sharedManager];
                            [manager deleteSQLImageDataWith:_imageRealSQLDataBase andTableName:_imageTableName];
                            [manager insertImageMessages:_urlImageMutArray toSQL:_imageRealSQLDataBase];
                            
                            [_MainView.mainMessageTableView reloadData];
                        });
            
        } error:^(NSError *error) {
            NSLog(@"网络请求错误");
        }];
    
    }else{
        [[ZRBCoordinateMananger sharedManager] fetchDataFromNetisReferesh:YES Succeed:^(NSArray *array) {
            if ( _titleMutArray1.count > 0 ){
                [_titleMutArray1 removeAllObjects];
                [_imageMutArray1 removeAllObjects];
                [_urlImageMutArray removeAllObjects];
            }
            [_idSelfMutArray removeAllObjects];
            [_allDateMutArray removeAllObjects];
            
            for (int i = 0; i < array.count; i++) {
                TotalJSONModel * totalJSONModel = array[i];
                //现在这里面有一天的数据
                //一天的数据
                NSMutableArray * titleMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * imageMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * idMutArray = [[NSMutableArray alloc] init];
                NSMutableArray * urlMutArray = [[NSMutableArray alloc] init];
                [_allDateMutArray addObject:totalJSONModel.date];
               
                NSArray * data = totalJSONModel.stories;
                    for (int i = 0; i < data.count; i++) {
                        StoriesJSONModel * storJSONMOdel = data[i];
                        [titleMutArray addObject:storJSONMOdel.title];
                        [idMutArray addObject:[NSNumber numberWithInteger:storJSONMOdel.id]];
                        NSURL * JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",storJSONMOdel.images[0]]];
                        [urlMutArray addObject:JSONUrl];
                        NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
                        UIImage * image = [UIImage imageWithData:imageData];
                        if ( image ){
                            [imageMutArray addObject:image];
                        }
                        
                    }
                [_titleMutArray1 addObject:titleMutArray];
                [_imageMutArray1 addObject:imageMutArray];
                [_idSelfMutArray addObject:idMutArray];
                [_urlImageMutArray addObject:urlMutArray];
            }
            NSNotification * reloadDateNotification = [NSNotification notificationWithName:@"reloadDataTongZhiController" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:reloadDateNotification];
        } error:^(NSError *error) {
            NSLog(@"网络请求错误");
        }];
        
    }
         //});
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        if (_ifNetRequestInteger == 0) {
            _haveGetSQLDataInteger = 1;
            [_allDateMutArray addObject:@"23333"];
            
            ZRBSQLiteManager * manager = [ZRBSQLiteManager sharedManager];
            [manager openSQLImageDataWith:_imageRealSQLDataBase andTableName:_imageTableName andimageMutArray:_urlImageMutArray];
            
            [self openSQLDataWith:_sqlDataBase andTableName:_tableName];
            
        }
    });
}

//接下来： 就是把uicode 编码串转化为中文字符 转换不成功的关键就是
//她把一个数组传给了NSString类型 导致她打印出来：数组！！！！

- (void)reloadDataTongZhiController:(NSNotification *)noti
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self deleteSQLDataWith:_sqlDataBase andTableName:_tableName];
//        [self insertMessages:_titleMutArray1 toSQL:_sqlDataBase];
        [_MainView.mainMessageTableView reloadData];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //if ([_allDateMutArray isKindOfClass:[NSArray class]] && _allDateMutArray.count > 0) {
    return _allDateMutArray.count;
   // }
//    if (_haveGetSQLDataInteger == 1 ){
//        return _haveGetSQLDataInteger;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRBNewsTableViewCell * cell1 = nil;
    cell1 = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    
    if ( cell1 == nil ){
        cell1 = [[ZRBNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
    }
        if ( _allDateMutArray.count == 1 ){
        if ( _titleMutArray1.count > 0 ){
            if (_haveGetSQLDataInteger == 0) {
                cell1.newsLabel.text = _titleMutArray1[indexPath.row][0];
                NSString * urlStr = [NSString stringWithFormat:@"%@",_urlImageMutArray[indexPath.row]];
                [cell1.newsImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
            }
            else if (_haveGetSQLDataInteger == 1) {
                cell1.newsLabel.text = _titleMutArray1[indexPath.row];
                NSString * urlStr = [NSString stringWithFormat:@"%@",_urlImageMutArray[indexPath.row]];
                [cell1.newsImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
            }
            
//            if (_imageMutArray1.count > 0){
//                NSString * urlStr = [NSString stringWithFormat:@"%@",_urlImageMutArray[indexPath.row]];
//                [cell1.newsImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
//            }
        }
    }else{
        if ( _allDateMutArray.count != 0 ){
                cell1.newsLabel.text = _titleMutArray1[indexPath.section][indexPath.row];
                cell1.newsImageView.image = _imageMutArray1[indexPath.section][indexPath.row];
        }
    }
    return cell1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"detailHeaderView"];
    if ( _headerFooterView == nil ){
        _headerFooterView = [[ZRBDetailsTableViewHeaderFooterView alloc] initWithReuseIdentifier:@"detailHeaderView"];
    }
    if ( section != 0 ){
        if ([_allDateMutArray isKindOfClass:[NSArray class]] && _allDateMutArray.count > 0){
            _headerFooterView.dateLabel.text = _allDateMutArray[section];
        }
    }
    return _headerFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ( section != 0 ){
    return 44;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( _allDateMutArray.count == 1 ){
        return _titleMutArray1.count;
    }
    if (_haveGetSQLDataInteger == 1) {
        return _titleMutArray1.count;
    }
    NSArray * array = [NSArray arrayWithObject:_titleMutArray1[section]];
    NSInteger i = 0;
    for (NSString * images in array[0]) {
        i++;
    }
    return i;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat minAlphaOffset = -64;
    CGFloat maxAlphaOffect = 200;
    CGFloat offSet = scrollView.contentOffset.y;
    CGFloat alpha = (offSet - minAlphaOffset) / (maxAlphaOffect - minAlphaOffset);
    _barImageView.alpha = alpha;
    NSLog(@"scrollView.contentSize.height = %.2f",scrollView.contentSize.height);//实际内容高度
    NSLog(@"scrollView.frame.size.height = %.2f",scrollView.frame.size.height);//屏幕可见高度
    NSLog(@"scrollView.contentOffset.y = %.2f",scrollView.contentOffset.y);//内容偏移量
    if ( alpha > 1 ){
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.14f green:0.51f blue:0.85f alpha:1.00f];
        if ( offSet > _headerFooterView.frame.size.height ){
            self.navigationController.navigationBar.hidden = YES;
        }else{
            self.navigationController.navigationBar.hidden = NO;
        }
    }else{
        self.navigationController.navigationBar.hidden = NO;
    }
    if (scrollView.bounds.size.height + scrollView.contentOffset.y >scrollView.contentSize.height) {
        
        [UIView animateWithDuration:1.0 animations:^{
            
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
            
        } completion:^(BOOL finished) {
            
           // NSLog(@"发起上拉加载");
            if ( _refresh ){
                //self.navigationController.navigationBar.hidden = YES;
                //NSLog(@"发起上拉加载assdasdasdsa");
            _MainView.testStr = @"你好,我是中国人";
                ZRBCoordinateMananger * manager = [ZRBCoordinateMananger sharedManager];
                manager.ifAdoultRefreshStr = @"用户已经刷新过一次";
                [self fenethMessageFromManagerBlock:YES];
                _refresh = NO;
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:1.0 animations:^{
                    
                    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                    
                }];
            });
        }];
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadDataTongZhiController" object:nil];
}

- (void)giveCellJSONModelToMainView:(NSMutableArray *)imaMutArray andTitle:(NSMutableArray *)titMutArray
{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    [self pushToWKWebView];
}

- (void)pushToWKWebView
{
    if ( _closeAndClickInteger % 2 != 0 ){
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
        _closeAndClickInteger--;
    }
    
    SecondaryMessageViewController * secondMessageViewController = [[SecondaryMessageViewController alloc] init];
    ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
    [requestJSONModel setStr];
    if (_allDateMutArray.count == 1) {
        requestJSONModel.idRequestStr = [NSString stringWithFormat:@"%@",_idSelfMutArray[_indexPath.section+_indexPath.row]];
        secondMessageViewController.resaveIdString = [NSString stringWithFormat:@"%@",_idSelfMutArray[_indexPath.section+_indexPath.row]];
        NSInteger intEger = [secondMessageViewController.resaveIdString integerValue];
        secondMessageViewController.idRequestMutArray = [NSMutableArray arrayWithArray:_idSelfMutArray];
    }else{
        secondMessageViewController.resaveIdString = [NSString stringWithFormat:@"%@",_idSelfMutArray[_indexPath.section][_indexPath.row]];
        requestJSONModel.idRequestStr = [NSString stringWithFormat:@"%@",_idSelfMutArray[_indexPath.section][_indexPath.row]];
        secondMessageViewController.idRequestMutArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < _idSelfMutArray.count; i++) {
        for (NSString * idStr in _idSelfMutArray[i]) {
            [secondMessageViewController.idRequestMutArray addObject:idStr];
        }
        }
    }
    [self.navigationController pushViewController:secondMessageViewController animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
