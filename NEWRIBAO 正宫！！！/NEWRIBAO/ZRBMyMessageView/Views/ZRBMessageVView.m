//
//  ZRBMessageVView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMessageVView.h"

@implementation ZRBMessageVView


- (void)initView
{
    _mainView = [[UIView alloc] init];
    _mainView.backgroundColor = [UIColor yellowColor];
    _guideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_guideButton setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    //_guideButton.frame = CGRectMake(30, 30, 30, 30);
    
    self.backgroundColor = [UIColor yellowColor];
    //[_mainView addSubview:_guideButton];
    //[self addSubview:_guideButton];
    //[self.view addSubview:_guideButton];
    
    //[self addSubview:_mainView];
    
    [self addSubview:_guideButton];
    
    //    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(self);
    //    }];
    
    [_guideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(20);
        //        make.left.mas_offset(20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
}

- (void)initScrollView
{
    
    _messageScrollew = [[UIScrollView alloc] init];
    _messageScrollew.backgroundColor = [UIColor darkGrayColor];
    //[_mainView addSubview:_messageScrollew];
    
    [self addSubview:_messageScrollew];
    
    [_messageScrollew mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self).offset(0);
        
        make.top.equalTo(self).offset(0);
        
        make.width.mas_equalTo(250);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
    }];
}

- (void)initMainTableView
{
    //    //在这里解析数据
    //   // _mainMessageTableView = [[UITableView alloc] init];
    //
    //    NSNotification * notification = [NSNotification notificationWithName:@"notification" object:nil];
    //    [[NSNotificationCenter defaultCenter] postNotification:notification];
    //
    //
    //    _analyJSONMutArray = [[NSMutableArray alloc] init];
    //
    //    NSLog(@"----------------------");
    //
    //
    //    _analyJSONModel = [[AnalysisJSONModel alloc] init];
    //
    //    [_analyJSONModel AnalysisJSON];
    
    //不是应该在这里打印 NSLog(@"_JSONModelMut ====  ---- %@ ----",_JSONModelMut);吗？
    
    //[analyJSONModel AnalysisJSON];
    
    
    //    NSLog(@"analyJSONModel.JSONModelMut = %@",_analyJSONModel.JSONModelMut);
    //
    //    if ( [_analyJSONModel.JSONModelMut isKindOfClass:[NSArray class]] && _analyJSONModel.JSONModelMut.count > 0 ){
    //    _analyJSONMutArray = [NSMutableArray arrayWithArray:_analyJSONModel.JSONModelMut];
    //    }
    //    NSLog(@"_analyJSONMutArray = %@",_analyJSONMutArray);
    
    //[_mainMessageTableView registerClass:<#(nullable Class)#> forCellReuseIdentifier:<#(nonnull NSString *)#>]
}

//接收通知后调用的方法
- (void)changJSONModel:(NSNotification *)noti
{
    //_analyJSONModel = [[AnalysisJSONModel alloc] init];
    
    //不是应该在这里打印 NSLog(@"_JSONModelMut ====  ---- %@ ----",_JSONModelMut);吗？
    
    
    
    NSLog(@"analyJSONModel.JSONModelMut = %@",_analyJSONModel.JSONModelMut);
    
    if ( [_analyJSONModel.JSONModelMut isKindOfClass:[NSArray class]] && _analyJSONModel.JSONModelMut.count > 0 ){
        _analyJSONMutArray = [NSMutableArray arrayWithArray:_analyJSONModel.JSONModelMut];
    }
    NSLog(@"_analyJSONMutArray = %@",_analyJSONMutArray);
    
    //在这里面进行cell 单元格的赋值
    _mainMessageTableView = [[UITableView alloc] init];
    
    _mainMessageTableView.delegate = self;
    _mainMessageTableView.dataSource = self;
    [self addSubview:_mainMessageTableView];
    
    [_mainMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(100);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
    }];
}

- (void)initTableView
{
    _messageTableView = [[UITableView alloc] init];
    
    [_messageTableView registerClass:[ZRBMessageTableViewCell class] forCellReuseIdentifier:@"messageCell"];
    
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    
    [self addSubview:_messageTableView];
    
    //给tableView 的高度 记得在下面留下50  因为还有 完成 和 夜间两个按钮
    [_messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self);
        //        make.top.equalTo(self);
        //        make.bottom.equalTo(self).offset(-50);
        //        make.width.mas_equalTo(250);
        //        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height-50);
        
        make.edges.equalTo(self);
    }];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZRBMessageTableViewCell * cell = nil;
    
    cell = [_messageTableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    
    //if ( indexPath.row == 0 ){
    
    //可以加一个判断 如果
    cell.nameLabel.text = @"萨缪";
    cell.nameLabel.font = [UIFont systemFontOfSize:13];
    
    //        UIImage * img = [UIImage imageNamed:@"122.jpg"];
    //        NSTextAttachment * textAttach = [[NSTextAttachment alloc] init];
    //        textAttach.image = img;
    //
    //        NSAttributedString * strA = [NSAttributedString attributedStringWithAttachment:textAttach];
    //        cell.imageLabel.attributedText = strA;
    cell.imageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"122.jpg"]];
    // }
    
    
    
    
    
    
    //还没有在  ViewController 中 调用呀
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //    if ( _mainMessageTableView ){
    //        //一种
    //    }else{
    //        //另一种
    //    }
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

