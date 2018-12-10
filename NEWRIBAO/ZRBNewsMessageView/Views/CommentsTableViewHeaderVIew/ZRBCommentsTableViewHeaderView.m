//
//  ZRBCommentsTableViewHeaderView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/24.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCommentsTableViewHeaderView.h"
#import <Masonry.h>
@implementation ZRBCommentsTableViewHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _commentsNumLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_commentsNumLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _commentsNumLabel.font = [UIFont systemFontOfSize:20];
    [_commentsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
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
