//
//  ZRBMainViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMainViewController.h"

@interface ZRBMainViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation ZRBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //UIScrollView * scrollView = [[UIScrollView alloc] init];
    //scrollView.delegate = self;
    
    
    //[self.view addSubview:scrollView];
    _refreshNumInteger = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"今日新闻";
    
    _refresh = YES;
    
//    _MainView.mainMessageTableView.de
    
    //以下为网络请求
//    _mainImageMutArray = [[NSMutableArray alloc] init];
//    _mainTitleMutArray = [[NSMutableArray alloc] init];
    _mainAnalyisMutArray = [[NSMutableArray alloc] init];
//    _MainView.titleMutArray = [[NSMutableArray alloc] init];
//    _MainView.imageMutArray = [[NSMutableArray alloc] init];
    
    _mainCellJSONModel = [[ZRBCellModel alloc] init];
    [_mainCellJSONModel giveCellJSONModel];
    _mainCellJSONModel.delegateCell = self;
    
    //以上为网络请求
    
    
    //开启滑动返回功能代码
    if ( [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    _scrollView.contentSize = CGSizeMake(0, 900);
//    _scrollView.contentSize.height = 900;
//    _scrollView.contentSize.height = _MainView.mainMessageTableView.height;
    _scrollView.delegate = self;
    
    
    _messageView = [[ZRBMessageVView alloc] init];
    
    
    
    [_messageView initTableView];
    
    [_scrollView addSubview:_messageView];
    
    //_viewController = [[ViewController alloc] init];
    
    // _viewController.view.backgroundColor = [UIColor yellowColor];
    //[self.view addSubview:_viewController.view];
    
    
    
    _MainView = [[ZRBMainVIew alloc] init];
    
    [_MainView initMainTableView];
    
    //    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view);
    //    }];
    //[scrollView addSubview:_MainView];
    
    
    //[_MainView addSubview:scrollView];
    
    [_MainView.leftNavigationButton addTarget:self action:@selector(pressLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _MainView.delegate = self;
    
    
    //    //滚动视图代理方法
    //    UIScrollView * scrollowView = [[UIScrollView alloc] init];
    //    scrollowView.delegate = self;
    
    [_scrollView addSubview:_MainView];
    
    _MainView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
//    [_MainView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    
    //这一下就万法皆通了么！！！！！！！！！！！
    //一直在疑惑怎么证明代理是加到ZRNMainView上的
    //这下就好了!!!
    _MainView.mainMessageTableView.delegate = self;
//    [self scrollViewDidScroll:_scrollView];
    //    _MainView.mainMessageTableView.de
    [self.view addSubview:_scrollView];
    
    [self fenethMessageFromManagerBlock];
    
    
    
    //注释掉
    
    
//    _messageView = [[ZRBMessageVView alloc] init];
//
//
//
//    [_messageView initTableView];
//
//    [self.view addSubview:_messageView];
//
//    //_viewController = [[ViewController alloc] init];
//
//    // _viewController.view.backgroundColor = [UIColor yellowColor];
//    //[self.view addSubview:_viewController.view];
//
//
//
//    _MainView = [[ZRBMainVIew alloc] init];
//
//    [_MainView initMainTableView];
//
////    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.edges.equalTo(self.view);
////    }];
//    //[scrollView addSubview:_MainView];
//
//
//    //[_MainView addSubview:scrollView];
//
//    [_MainView.leftNavigationButton addTarget:self action:@selector(pressLeftBarButton:) forControlEvents:UIControlEventTouchUpInside];
//
//
//    _MainView.delegate = self;
//
//
////    //滚动视图代理方法
////    UIScrollView * scrollowView = [[UIScrollView alloc] init];
////    scrollowView.delegate = self;
//
//    [self.view addSubview:_MainView];
//
//    [_MainView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//
//    //这一下就万法皆通了么！！！！！！！！！！！
//    //一直在疑惑怎么证明代理是加到ZRNMainView上的
//    //这下就好了!!!
//    _MainView.mainMessageTableView.delegate = self;
////    _MainView.mainMessageTableView.de
//    [self fenethMessageFromManagerBlock];
    
    
    //注释掉
    
    
    
}

//manager类网络请求
- (void)fenethMessageFromManagerBlock
{
    _MainView.titleMutArray = [[NSMutableArray alloc] init];
    _MainView.imageMutArray = [[NSMutableArray alloc] init];
    _mainImageMutArray = [[NSMutableArray alloc] init];
    _mainTitleMutArray = [[NSMutableArray alloc] init];
    _titleMutArray = [[NSMutableArray alloc] init];
    _imageMutArray = [[NSMutableArray alloc] init];
    
    //测试
    NSString * mainTestStr = [[NSString alloc] init];
    
    [[ZRBCoordinateMananger sharedManager] fetchDataWithMainJSONModelsucceed:^(NSMutableArray *JSONModelMutArray) {
        if ( [JSONModelMutArray isKindOfClass:[NSArray class]] && JSONModelMutArray.count > 0 ){
            //if ( !_analyJSONMutArray ){
                _analyJSONMutArray = [[NSMutableArray alloc] init];
           // }
           // [_analyJSONMutArray addObject:JSONModelMutArray];
            
            
            _analyJSONMutArray = [NSMutableArray arrayWithArray:JSONModelMutArray];
        }
        
        NSLog(@"12321312131312 JSONModelMutArray == = =%@ ",JSONModelMutArray);
        
        for ( int i = 0; i < _analyJSONMutArray.count; i++ ) {
            ZRBMainJSONModel * titleModel = [[ZRBMainJSONModel alloc] init];
            //StoriesJSONModel * storiesModel = [[StoriesJSONModel alloc] init];
            
            
           // if ( _analyJSONMutArray.count-1 == i ){
            titleModel = _analyJSONMutArray[i];
//                NSLog(@"%@",titleModel.title);
//                NSString * title = [NSString stringWithFormat:@"%@",titleModel.title];
                //if ( titleModel ){
               //     if ( titleModel.title )
            [_titleMutArray addObject:titleModel.title];
             //   }
          //  }
            //NSLog(@"-------titleModel---- == = %@--",_analyJSONMutArray[i]);
            
            //为什么加不上去？？？？？
            //NSLog(@"titleModel.title === %@",titleModel.title);
//            if ( titleModel.title != nil ){
//            [_titleMutArray addObject:titleModel.title];
//            }
            
            NSLog(@"1232132132132132132132131");
            
            //打印下来是【Images】 但是API分析里是image
            //现在问题是 他把StoriesJSONModel 和 MainJSONModel  里的image弄混了
            //一个是Images 一个是image
            
            
            //NSString * JSONImageStr = [NSString stringWithFormat:@"%@",titleModel.images];
            
            NSURL *JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",titleModel.images[0]]];
            
            NSLog(@"titleModel.image === %@",titleModel.images);

            NSLog(@"JSONImageStr == %@",JSONUrl);
            
            NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
            UIImage * image = [UIImage imageWithData:imageData];
            
            if ( image ){
                [_imageMutArray addObject:image];
                
                
            }
            
        }
        
//        _MainView.titleMutArray = [[NSMutableArray alloc] init];
//        _MainView.imageMutArray = [[NSMutableArray alloc] init];
        
        [_mainImageMutArray setArray:_imageMutArray];
        [_mainTitleMutArray setArray:_titleMutArray];
        
        
        //另一个方法 就按之前的那样来  然后在COntroller层把 这两个数组传入到一个总数组中
        
        
        //这个方法 完全可行 可以在Controller层赋值了
//        if ( !_MainView.imageMutArray ){
//        [_MainView.imageMutArray setArray:_mainImageMutArray];
//        [_MainView.titleMutArray setArray:_mainTitleMutArray];
//        }else{
        
        [_MainView.imageMutArray addObject:_mainImageMutArray];
        [_MainView.titleMutArray addObject:_mainTitleMutArray];
        //}
        //mainTestStr = @"我是中国人";
        
        
        
        
        NSLog(@"COntroller中的 _imageMutArray = == = = =%@",_imageMutArray);
        
        NSLog(@"Controlwqweqwe _MainView.imageMutArray = = = =%@",_MainView.imageMutArray);
        //创建一个通知
        NSNotification * reloadDataNotification = [NSNotification notificationWithName:@"reloadDataTongZhi" object:nil userInfo:nil];
        
        //创建并发送通知 然后在View层执行通知 通知的内容是更新视图
        //问题是
        [[NSNotificationCenter defaultCenter] postNotification:reloadDataNotification];
        
        
    } error:^(NSError *error) {
        NSLog(@"网络请求出错-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
    }];
    
    
    
    //以上为刚才修改  ： 注释掉
    
    //    [ZRBCoordinateMananger sharedManager] fetchDataWithMainJSONModel:^(NSMutableArray *obj) {
    //        <#code#>
    //    };
}

//- (void)scrollViewDid

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"发起上拉加载12321312321");
    if (scrollView.bounds.size.height + scrollView.contentOffset.y >scrollView.contentSize.height) {
        
        [UIView animateWithDuration:1.0 animations:^{
            
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
            
        } completion:^(BOOL finished) {
            
            NSLog(@"发起上拉加载");
            if ( _refresh ){
                NSLog(@"发起上拉加载assdasdasdsa");
            _MainView.testStr = @"你好,我是中国人";
                ZRBCoordinateMananger * manager = [ZRBCoordinateMananger sharedManager];
                //manager.ifAdoultRefreshStr = [NSString stringWithFormat:@"%@",@"用户已经刷新过一次"];
                manager.ifAdoultRefreshStr = @"用户已经刷新过一次";
                NSLog(@"manager.ifAdoultRefreshStr = == == = = %@",manager.ifAdoultRefreshStr);
                [self fenethMessageFromManagerBlock];
                
                //目前问题：
                //如果变成NO的话 那么她就再加载不了了
                //加载5天的数据
                //那么创建多个if 语句就好 创建一个数组 存储每次存入的NSString
                //创建一个NSInteger变量 每次向下加载一次++ 一次该变量 然后在各种该变量应该具有的值
                //1 2 3 4 5 的几种if 可能中 给昨天 前天 大前天 对应的 NSString * 类型的字符串赋值
                
                //刷新次数到最后一次时  给 _refresh设置为 NO 不要进入这个方法，，，
                
                _refresh = NO;
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:1.0 animations:^{
                    
                    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                    
                }];
            });
        }];
        
        
    }
    //    if ( _MainView.analyJSONMutArray.count == 0 || _MainView.mainMessageTableView.isHidden == NO ){
    //        return;
    //    }
    //
    //    CGFloat offsetY = scrollView.contentOffset.y;
    //
    //    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    //
    //
    //    //不知道这样还能用不
    //    //与那个博客上的赋值方法不相符合！！！！
    //
    //    //当最后一个CELL完全显示在眼前时
    //    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.contentSize.height - _MainView.mainMessageTableView.tableFooterView.frame.size.height;
    //
    //    if ( offsetY >= judgeOffsetY ){
    //        //最后一个CELL完全进入视野
    //        //显示footer
    //        _MainView.mainMessageTableView.tableFooterView.hidden = NO;
    //
    //        //加载更多数据
    //        //就把那个 正在加载中 弄出来
    //
    //        //这是那个异步请求数据的方法 不是那个UIVIew视图
    //
    //        //这里需要修改一下！！！！！！
    //
    //
    //
    //        //现在问题是 问崔总 下拉刷新怎么搞？？思路是什么
    //        //还有他说的那个 写一个方法 传值 怎么搞？？？
    //
    //
    //
    //
    //
    //        //判断一下 最后一个CELL 网址找好了！！！
    ////        还有这里修改一下
    //        [_MainView loadMoreView];
    //    }
    
    
}

- (void)giveCellJSONModelToMainView:(NSMutableArray *)imaMutArray andTitle:(NSMutableArray *)titMutArray
{
//    _mainImageMutArray = [[NSMutableArray alloc] init];
//    _mainTitleMutArray = [[NSMutableArray alloc] init];
//    _MainView.titleMutArray = [[NSMutableArray alloc] init];
//    _MainView.imageMutArray = [[NSMutableArray alloc] init];
//
//    [_mainImageMutArray setArray:imaMutArray];
//    [_mainTitleMutArray setArray:titMutArray];
//
//    [_MainView.imageMutArray setArray:_mainImageMutArray];
//    [_MainView.titleMutArray setArray:_mainTitleMutArray];
//
//    //创建一个通知
//    NSNotification * reloadDataNotification = [NSNotification notificationWithName:@"reloadDataTongZhi" object:nil userInfo:nil];
//
//    //创建并发送通知 然后在View层执行通知 通知的内容是更新视图
//    //问题是
//    [[NSNotificationCenter defaultCenter] postNotification:reloadDataNotification];

//    dispatch_async(dispatch_get_main_queue(), ^{
//        [_MainView.mainMessageTableView reloadData];
//    });

    NSLog(@"****************    imaMutArray = == = = =%@",imaMutArray);
    NSLog(@"****************Controlller代理协议里的  _imageMutArray = == = = = = == = %@",_mainImageMutArray);
}



- (void)pushToWKWebView
{
    //UIViewController * currentViewControlller = [self getCurrentVC];
    
    //现在的问题是 在这里设置断点  但是 不走 SecondaryMessageViewController.m文件中的viewDidLoad方法
    SecondaryMessageViewController * secondMessageViewController = [[SecondaryMessageViewController alloc] init];
    
    
    
    //UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:secondMessageViewController];
    
    [self.navigationController pushViewController:secondMessageViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"每日新闻";

    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1.png"] style:UIBarButtonItemStyleDone target:self action:@selector(pressLeftBarButton:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)pressLeftBarButton:(UIBarButtonItem *)leftBtn
{
    NSLog(@"666666");
    if ( _iNum == 0 ){
        [_MainView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //        make.height.mas_equalTo(self.view.bounds.size.height);
            //        make.width.mas_equalTo(
            make.left.equalTo(self.view).offset(250);
            make.top.equalTo(self.view).offset(0);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-250);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
            
            //创建另一个controller
            
            
            
            [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view);
                make.top.equalTo(self.view).offset(50);
                make.bottom.equalTo(self.view).offset(-50);
                make.width.mas_equalTo(250);
                make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-100);
            }];
            
            //make.edges.equalTo(self.view);
        }];
        //在这里new 一个新的视图！
        
        //[_aView initScrollView];
        _iNum++;
    }
    
    
    else{
        [_MainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        //在这里new出来的新视图 坐标改变！
        _iNum--;
    }
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
