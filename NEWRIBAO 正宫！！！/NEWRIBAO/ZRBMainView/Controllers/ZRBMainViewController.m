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
    
    
    
}

//manager类网络请求
- (void)fenethMessageFromManagerBlock
{
    //教训 传变量时不能用@property 给本界面设置数组 要直接在哪个函数调用 就在哪个函数
    //NSMutableArray * titleMutArray = [NSMutableArray alloc] init 就行
    //因为 这是个指针 @property 之后 她赋值只会给最后一个变量赋值
    
    
    _mainImageMutArray1 = [[NSMutableArray alloc] init];
    _mainTitleMutArray1 = [[NSMutableArray alloc] init];
    _titleMutArray1 = [[NSMutableArray alloc] init];
    _imageMutArray1 = [[NSMutableArray alloc] init];
    
    NSMutableArray * _titleMutArray = [[NSMutableArray alloc] init];
    NSMutableArray * _imageMutArray = [[NSMutableArray alloc] init];
    NSMutableArray * _mainImageMutArray = [[NSMutableArray alloc] init];
    NSMutableArray * _mainTitleMutArray = [[NSMutableArray alloc] init];
    //测试
    NSString * mainTestStr = [[NSString alloc] init];
    
    __block ZRBCoordinateMananger * manager = [ZRBCoordinateMananger sharedManager];
    
    [[ZRBCoordinateMananger sharedManager] fetchDataWithMainJSONModelsucceed:^(ZRBOnceUponDataJSONModel * OnceUpOnJSONModel) {
        
        
//                if ( _titleMutArray.count > 0 ){
//                    [_titleMutArray removeAllObjects];
//                }
//                if ( _imageMutArray.count > 0 ){
//                    [_imageMutArray removeAllObjects];
//                }
        
        //解析JSONModel咋突然不会了
        NSDictionary * obj = [[NSDictionary alloc] init];
        obj = [OnceUpOnJSONModel toDictionary];
        
        for (int i = 0; i < OnceUpOnJSONModel.stories.count; i++) {
            ZRBStoriesGoJSONModel * beforeStroiesGoJSONMOdel = [[ZRBStoriesGoJSONModel alloc] initWithDictionary:obj[@"stories"][i] error:nil];
            NSLog(@"_beforeStoriesGoJSONModel == =  %@",beforeStroiesGoJSONMOdel);
            
            [_MainView.titleMutArray addObject:beforeStroiesGoJSONMOdel.title];
            NSURL *JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",beforeStroiesGoJSONMOdel.images[0]]];
            NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
            UIImage * image = [UIImage imageWithData:imageData];
            if ( image ){
                [_MainView.imageMutArray addObject:image];
            }
        }
        
        //每次进来都会添加日期
        [_MainView.dateNowMutArray addObject:obj[@"date"]];
        
        //创建一个通知
        NSNotification * reloadDataNotification = [NSNotification notificationWithName:@"reloadDataTongZhi" object:nil userInfo:nil];
        
        //创建并发送通知 然后在View层执行通知 通知的内容是更新视图
        //问题是
        [[NSNotificationCenter defaultCenter] postNotification:reloadDataNotification];
        
        
        //JSONModel 数据类型直接转换成为数组 或字典类型的方法  [JOSNModel toDictionary/array];
        
        
        
//        if ( _titleMutArray.count > 0 ){
//            [_titleMutArray removeAllObjects];
//        }
//        if ( _imageMutArray.count > 0 ){
//            [_imageMutArray removeAllObjects];
//        }
//
//        if ( [JSONModelMutArray isKindOfClass:[NSArray class]] && JSONModelMutArray.count > 0 ){
//            _analyJSONMutArray = [NSMutableArray arrayWithArray:JSONModelMutArray];
//        }
//
//        for ( int i = 0; i < _analyJSONMutArray.count; i++ ) {
//            ZRBMainJSONModel * titleModel = [[ZRBMainJSONModel alloc] init];
//
//            titleModel = _analyJSONMutArray[i];
//            [_titleMutArray addObject:titleModel.title];
//
//            NSURL *JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",titleModel.images[0]]];
//            NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
//            UIImage * image = [UIImage imageWithData:imageData];
//            if ( image ){
//                [_imageMutArray addObject:image];
//            }
//        }
//        [_mainImageMutArray setArray:_imageMutArray];
//        [_mainTitleMutArray setArray:_titleMutArray];
//#pragma market
//
//        if ( !_MainView.titleMutArray ){
//            _MainView.titleMutArray = [NSMutableArray array];
//        }
//        if ( !_MainView.imageMutArray ){
//            _MainView.imageMutArray = [NSMutableArray array];
//        }
//
//        NSLog(@"_MainView.titleMutArray.count = %li",_MainView.titleMutArray.count);
//        NSInteger titleCountInteger = 0;
//        titleCountInteger = _titleMutArray.count;
//
//            for (int i = 0; i < _titleMutArray.count; i++) {
//                NSInteger flag = 0;
//                NSString * str = _titleMutArray[i];
//                for (int i = 0; i < _MainView.titleMutArray.count; i++) {
//                    if ( [str isEqualToString:[NSString stringWithFormat:@"%@",_MainView.titleMutArray[i]]] ){
//                        flag = 1;
//                        break;
//                    }
//                }
//                if ( flag == 0 ){
//                    [_MainView.titleMutArray addObject:_titleMutArray[i]];
//                    [_MainView.imageMutArray addObject:_imageMutArray[i]];
//                }
//            }
//        //创建一个通知
//        NSNotification * reloadDataNotification = [NSNotification notificationWithName:@"reloadDataTongZhi" object:nil userInfo:nil];
//
//        //创建并发送通知 然后在View层执行通知 通知的内容是更新视图
//        //问题是
//        [[NSNotificationCenter defaultCenter] postNotification:reloadDataNotification];
        
//        manager = nil;
    } error:^(NSError *error) {
        NSLog(@"网络请求出错-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
    }];
    

}


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
                manager.ifAdoultRefreshStr = @"用户已经刷新过一次";
                NSLog(@"manager.ifAdoultRefreshStr = == == = = %@",manager.ifAdoultRefreshStr);
                [self fenethMessageFromManagerBlock];
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

- (void)giveCellJSONModelToMainView:(NSMutableArray *)imaMutArray andTitle:(NSMutableArray *)titMutArray
{

    NSLog(@"****************    imaMutArray = == = = =%@",imaMutArray);
    NSLog(@"****************Controlller代理协议里的  _imageMutArray = == = = = = == = %@",_mainImageMutArray1);
}



- (void)pushToWKWebView
{

    //现在的问题是 在这里设置断点  但是 不走 SecondaryMessageViewController.m文件中的viewDidLoad方法
    SecondaryMessageViewController * secondMessageViewController = [[SecondaryMessageViewController alloc] init];
    
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
