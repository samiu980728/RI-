//
//  ZRBNewsTableViewCell.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBNewsTableViewCell.h"

@implementation ZRBNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ){
        _newsLabel = [[UILabel alloc] init];
        _newsImageView = [[UIImageView alloc] init];
        
        _newsLabel.font = [UIFont systemFontOfSize:15];
        _newsLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_newsImageView];
        [self.contentView addSubview:_newsLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        //        make.right.equalTo(_newsImageView.mas_left).offset(-10);
        make.top.equalTo(self).offset(10);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(self);
    }];
    
    //_newsImageView.backgroundColor = [UIColor blueColor];
    [_newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_newsLabel.mas_right).offset(15);
        make.top.equalTo(self).offset(10);
        //        make.right.equalTo(self).offset(-10);
        
        make.width.mas_equalTo(70);
        //        make.height.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

