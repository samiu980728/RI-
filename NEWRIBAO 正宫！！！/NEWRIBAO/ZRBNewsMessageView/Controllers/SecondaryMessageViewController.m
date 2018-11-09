//
//  SecondaryMessageViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "SecondaryMessageViewController.h"

@interface SecondaryMessageViewController ()

@end

@implementation SecondaryMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //屏蔽右滑返回功能代码：
//    if ( [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
    
    NSLog(@"fadsfa");
    
    //创建一个通知 在通知里面传值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Dicttongzhi1:) name:@"Dicttongzhi1" object:nil];
    
    
    _mainWebView = [[ZRBMainWKWebView alloc] init];
    
    _requestModel = [[ZRBRequestJSONModel alloc] init];
    
    [_requestModel requestJSONModel];
    //这里已经得到网络中的数据 启用代理
    
//    if ( [_delegate respondsToSelector:@selector(giveJSONModelMessageToView)] ){
//        [_delegate giveJSONModelMessageToView];
//    }
    
    _mainWebView.modelStr = [NSString stringWithFormat:@"%@",_requestModel.modelStr];
    
//    [_mainWebView reload]
//    [_mainWebView viewload]
    //_mainWebView.modelStr = _requestModel.modelStr;
    
    [_mainWebView createAndGetJSONModelWKWebView];
    
    [_mainWebView recieveNotification];
    
    //由于自定义返回按钮，所以iOS7自带返回手势无效。在需要的页面加上navigationController.interactivePopGestureRecognizer.delegate = self 返回手势好用了。
    //self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    
    //[_mainWebView.panGestureRecognizer addTarget:self action:@selector(handlePan:)];
    
    [self.view addSubview:_mainWebView];
    
    [_mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //[self.navigationController setNavigationBarHidden:YES animated:<#(BOOL)#>]
//    id target = self.
    
}

- (void)Dicttongzhi1:(NSNotification *)noti
{
//    NSLog(@"_mainWebView.modelStr === ----- -- -- - -- - - - - - -- - -- --- -- %@",_mainWebView.modelStr);
    
    _mainWebView.modelStr = _requestModel.modelStr;
    //_mainWebView.modelStr = [NSString stringWithFormat:@"%@",_requestModel.modelStr];
    NSLog(@"_mainWebView.modelStr === ----- -- -- - -- - - - - - -- - -- --- -- %@",_mainWebView.modelStr);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

//- (void)handlePan:(UIPanGestureRecognizer *) recognizer
//{
//    CGPoint translation = [recognizer translationInView:self.view];
//    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
//                                         recognizer.view.center.y + translation.y);
//    [recognizer setTranslation:CGPointZero inView:self.view];
//
//}

//- (void)viewDidAppear:(BOOL)animated
//{
//    __weak typeof(self) weakSelf = self;
//    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
//}


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
