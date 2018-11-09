//
//  ZRBDetailsTableViewHeaderFooterView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/31.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBDetailsTableViewHeaderFooterView.h"
#import <Masonry.h>
@implementation ZRBDetailsTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if ( self ){
        _dateLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_dateLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    
    _dateLabel.font = [UIFont systemFontOfSize:15];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(150);
        make.width.equalTo(@200);
        make.height.equalTo(self);
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
