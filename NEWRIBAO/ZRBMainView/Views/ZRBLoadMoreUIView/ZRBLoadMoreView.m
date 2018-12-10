//
//  ZRBLoadMoreView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/4.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBLoadMoreView.h"
#import <Masonry.h>
@implementation ZRBLoadMoreView
- (void)footer
{
    UILabel * label = [[UILabel alloc] init];
    label.text = @"正在加载中...";
    label.font = [UIFont systemFontOfSize:20];
    
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
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
