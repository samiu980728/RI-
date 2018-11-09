//
//  ZRBMyMessageViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMyMessageViewController.h"

@interface ZRBMyMessageViewController ()

@end

@implementation ZRBMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _iNum = 0 ;
    
    _aView = [[ZRBMessageVView alloc] init];
    
    _bView = [[ZRBMessageVView alloc] init];
    
    //_MView = [[ZRBMainVIew alloc] init];
    
    //[_MView initMainTableView];
    //[_bView initScrollView];
    
    [_bView initTableView];
    
    
    
    //[_aView initView];
    // [_aView.guideButton addTarget:self action:@selector(showSelectColumn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_aView initMainTableView];
    
    //[self.view addSubview:_bView];
    [self.view addSubview:_aView];
    //[self.view addSubview:_MView];
    
    [_aView.messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
        make.width.mas_equalTo(414);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-50);
        
        
        //make.edges.equalTo(self.view);
    }];
    
    
    
    [_aView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self.view);
        //        make.top.equalTo(self.view).offset(50);
        //        make.bottom.equalTo(self.view).offset(-50);
        //        make.width.mas_equalTo(250);
        //        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-100);
        
        make.edges.equalTo(self.view);
    }];
    
    
    
    //    [_bView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(self.view).mas_offset(0);
    //        make.top.mas_equalTo(self.view).mas_offset(0);
    //        make.width.mas_equalTo(250);
    //        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
    //
    //    }];
    //
    //    [_MView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(self.view);
    //    }];
    
    
}


- (void)pressLeftBarButton:(UIBarButtonItem *)leftBtn
{
    NSLog(@"666666");
    if ( _iNum == 0 ){
        [_aView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //        make.height.mas_equalTo(self.view.bounds.size.height);
            //        make.width.mas_equalTo(
            make.left.equalTo(self.view).offset(250);
            make.top.equalTo(self.view).offset(0);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
            //make.edges.equalTo(self.view);
        }];
        //在这里new 一个新的视图！
        
        //[_aView initScrollView];
        _iNum++;
    }
    
    
    else{
        [_aView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        //在这里new出来的新视图 坐标改变！
        _iNum--;
    }
}


//这本身就是个scrollView  !! 只是一开始展示的是第二页！！！
//点击butoon 后 mainView 右移 重新设置frame
- (void)showSelectColumn:(UIButton *)btn
{
    NSLog(@"666666");
    if ( _iNum == 0 ){
        [_aView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //        make.height.mas_equalTo(self.view.bounds.size.height);
            //        make.width.mas_equalTo(
            make.left.equalTo(self.view).offset(250);
            make.top.equalTo(self.view).offset(0);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
            //make.edges.equalTo(self.view);
        }];
        //在这里new 一个新的视图！
        
        //[_aView initScrollView];
        _iNum++;
    }
    
    
    else{
        [_aView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        //在这里new出来的新视图 坐标改变！
        _iNum--;
    }
    
    
    //[_aView initScrollView];
    
    //    [_aView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        //        make.height.mas_equalTo(self.view.bounds.size.height);
    //        //        make.width.mas_equalTo(
    //        make.left.mas_equalTo(_aView.messageScrollew.mas_right).mas_offset(20);
    //    }];
}

- (void)returnButton:(UIButton *)btn
{
    [_aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    btn.selected = !btn.selected;
}

//点击任意位置 视图移动到原位
//还得添加一个事件  按钮是否是 被选择状态？？？


//- (void)viewWillDisappear:(BOOL)animated
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notification" object:nil];
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

