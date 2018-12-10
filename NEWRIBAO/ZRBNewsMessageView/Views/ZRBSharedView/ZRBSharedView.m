//
//  ZRBSharedView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBSharedView.h"
#import <Masonry.h>
@implementation ZRBSharedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ){
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:self.collectionButton];
        [self addSubview:self.cancelButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
    self.collectionButton.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.collectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        //make.width.equalTo(self).offset(30);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(@20);
    }];
    
    
    //字还没有显示出来！！！！
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelButton.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionButton.mas_bottom).offset(20);
        //make.width.equalTo(self).offset(30);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(@50);
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
