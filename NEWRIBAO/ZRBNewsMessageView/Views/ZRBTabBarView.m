//
//  ZRBTabBarView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/19.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBTabBarView.h"
#import <Masonry.h>
@implementation ZRBTabBarView

- (instancetype)initWithFrame:(CGRect)frame andAllapproval:(NSInteger)allApprovalNum andComments:(NSInteger)commentsNum
{
    self = [super initWithFrame:frame];
    if (self) {
        self.shareNewsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentNewsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.giveApproveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.goNextNewsViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.returnMainViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.allCommentsLabel = [[UILabel alloc] init];
        self.commentsNumLabel = [[UILabel alloc] init];
        _allCommentsLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:allApprovalNum]];
        _commentsNumLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:commentsNum]];
        
        [self addSubview:_commentsNumLabel];
        [self addSubview:_allCommentsLabel];
        [self addSubview:_shareNewsButton];
        [self addSubview:_commentNewsButton];
        [self addSubview:_giveApproveButton];
        [self addSubview:_goNextNewsViewButton];
        [self addSubview:_returnMainViewButton];
    }
    return self;
}

//开 点赞 数字的位置！！！
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger padding = 40;
    
    //_allCommentsLabel.text = @"40";
    _allCommentsLabel.backgroundColor = [UIColor orangeColor];
    _allCommentsLabel.font = [UIFont systemFontOfSize:10];
    
    _commentsNumLabel.backgroundColor = [UIColor orangeColor];
    _commentsNumLabel.font = [UIFont systemFontOfSize:10];
    self.backgroundColor = [UIColor whiteColor];
    [_returnMainViewButton setImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
    [_goNextNewsViewButton setImage:[UIImage imageNamed:@"4.png"] forState:UIControlStateNormal];
    [_giveApproveButton setImage:[UIImage imageNamed:@"5.png"] forState:UIControlStateNormal];
    [_shareNewsButton setImage:[UIImage imageNamed:@"6.png"] forState:UIControlStateNormal];
    [_commentNewsButton setImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateNormal];
    
    [@[_returnMainViewButton,_goNextNewsViewButton,_giveApproveButton,_shareNewsButton,_commentNewsButton] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:20 tailSpacing:20];
    [@[_returnMainViewButton,_goNextNewsViewButton,_giveApproveButton,_shareNewsButton,_commentNewsButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    [_allCommentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(_giveApproveButton.mas_right).offset(-10);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    [_commentsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(_commentNewsButton.mas_right).offset(-10);
        //make.right.equalTo(self);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
}

- (void)initCommentView
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
