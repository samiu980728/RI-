//
//  ZRBMessageVView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMessageVView.h"
#import <Masonry.h>
@implementation ZRBMessageVView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ){
        self.presonImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_presonImageButton];
        
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_collectionButton];
        
        self.newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_newsButton];
        
        self.setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_setButton];

        self.mainNewsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_mainNewsButton];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.presonImageButton.imageView.layer.cornerRadius = self.presonImageButton.imageView.frame.size.width/2;
    self.presonImageButton.layer.masksToBounds = YES;
    [self.presonImageButton setImage:[UIImage imageNamed:@"16.png"] forState:UIControlStateNormal];
    [self.presonImageButton setTitle:@"请登录" forState:UIControlStateNormal];
    [self.presonImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.presonImageButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //self.mainNewsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.presonImageButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 200)];
    [self.presonImageButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 150)];
    
    [self.presonImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(self.mas_width);
    }];
    
    [self.collectionButton setImage:[UIImage imageNamed:@"12.png"] forState:UIControlStateNormal];
    [self.collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
    [self.collectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.collectionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //设置边距 距离顶部 上移下方文字的高度 距离右边 右移文字的宽度
    
    //原本的位置为：UIEdgeInsetsMake里面的四个参数表示距离上边界、左边界、下边界、右边界的距离，默认都为零，title／image在button的正中央
    //还记得我们一开始设定的正负方向吗，(warning：left以右为正方向，right以左为正方向，但是可以帮助理解下面进行偏移时+ -距离，top向下为正和bottom向上为正，这个可以参照使用masonry进行约束设置判定方向)。
    
    //将image的偏移量距右边的距离减少了titleLabel的宽度 使其居中
    //将image的偏移量距上边的距离减少了titleLabel的高度
    [self.collectionButton setImageEdgeInsets:UIEdgeInsetsMake(-self.collectionButton.titleLabel.intrinsicContentSize.height, 0, 0, -self.collectionButton.titleLabel.intrinsicContentSize.width)];
    
    //上边距图片的高度加20
    //将title的偏移量距上边的距离增加了image的高度+20
    //距左边的距离减少了image的宽度
    [self.collectionButton setTitleEdgeInsets:UIEdgeInsetsMake(self.collectionButton.currentImage.size.height+20, -self.collectionButton.currentImage.size.width, 0, 0)];
   
    //下一步 设置另外两个的图片加文字
    
    [self.newsButton setImage:[UIImage imageNamed:@"13.png"] forState:UIControlStateNormal];
    [self.newsButton setTitle:@"消息" forState:UIControlStateNormal];
    [self.newsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.newsButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.newsButton setImageEdgeInsets:UIEdgeInsetsMake(-self.newsButton.titleLabel.intrinsicContentSize.height, 0, 0, -self.newsButton.titleLabel.intrinsicContentSize.width)];
    [self.newsButton setTitleEdgeInsets:UIEdgeInsetsMake(self.newsButton.currentImage.size.height+20, -self.newsButton.currentImage.size.width, 0, 0)];
    
    [self.setButton setImage:[UIImage imageNamed:@"14.png"] forState:UIControlStateNormal];
    [self.setButton setTitle:@"设置" forState:UIControlStateNormal];
    [self.setButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.setButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.setButton setImageEdgeInsets:UIEdgeInsetsMake(-self.setButton.titleLabel.intrinsicContentSize.height, 0, 0, -self.setButton.titleLabel.intrinsicContentSize.width)];
    [self.setButton setTitleEdgeInsets:UIEdgeInsetsMake(self.setButton.currentImage.size.height+20, -self.setButton.currentImage.size.width, 0, 0)];
    
    [@[self.collectionButton,self.newsButton,self.setButton] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:10];
    [@[self.collectionButton,self.newsButton,self.setButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.presonImageButton.mas_bottom).offset(30);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.mainNewsButton setImage:[UIImage imageNamed:@"15.png"] forState:UIControlStateNormal];
    [self.mainNewsButton setTitle:@"首页" forState:UIControlStateNormal];
    [self.mainNewsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.mainNewsButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //self.mainNewsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.mainNewsButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 200)];
    [self.mainNewsButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 150)];
    
    [self.mainNewsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionButton.mas_bottom).offset(30);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(100);
        make.left.mas_equalTo(self.mas_left);
    }];
}




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
    
}

//接收通知后调用的方法
- (void)changJSONModel:(NSNotification *)noti
{
    if ( [_analyJSONModel.JSONModelMut isKindOfClass:[NSArray class]] && _analyJSONModel.JSONModelMut.count > 0 ){
        _analyJSONMutArray = [NSMutableArray arrayWithArray:_analyJSONModel.JSONModelMut];
    }
    NSLog(@"_analyJSONMutArray = %@",_analyJSONMutArray);
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
    cell.nameLabel.text = @"萨缪";
    cell.nameLabel.font = [UIFont systemFontOfSize:13];
    cell.imageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"122.jpg"]];
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
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

