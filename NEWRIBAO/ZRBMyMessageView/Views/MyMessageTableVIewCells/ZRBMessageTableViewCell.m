//
//  ZRBMessageTableViewCell.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMessageTableViewCell.h"

@implementation ZRBMessageTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ){
        _imageLabel = [[UILabel alloc] init];
        _collectionButton = [[UIButton alloc] init];
        _newsButton = [[UIButton alloc] init];
        _setButton = [[UIButton alloc] init];
        _homePageButton = [[UIButton alloc] init];
        _momentButton = [[UIButton alloc] init];
        _nameLabel = [[UILabel alloc] init];
        _homePageImageLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_imageLabel];
        [self.contentView addSubview:_collectionButton];
        [self.contentView addSubview:_newsButton];
        [self.contentView addSubview:_setButton];
        [self.contentView addSubview:_homePageButton];
        [self.contentView addSubview:_momentButton];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_homePageImageLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageLabel.layer.cornerRadius = 3.0;
    [[_imageLabel layer] setMasksToBounds:YES];
    
    [_imageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageLabel.mas_right).offset(20);
        make.top.equalTo(self).offset(7);
        make.bottom.equalTo(self).offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [_collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    [_newsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_collectionButton.mas_right).offset(50);
        make.top.equalTo(self);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    [_setButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_newsButton.mas_right).offset(50);
        make.top.equalTo(@7);
        
        // make.right.equalTo(self).offset(-45);//三个全加到205 共250
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        
    }];
    
    [_homePageImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        
    }];
    
    [_homePageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_homePageImageLabel.mas_right).offset(30);
        make.top.equalTo(self);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [_momentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
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

