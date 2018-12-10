//
//  ZRBMessageTableViewCell.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface ZRBMessageTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel * imageLabel;

@property (nonatomic,strong) UIButton * collectionButton;

@property (nonatomic, strong) UIButton * newsButton;

@property (nonatomic, strong) UIButton * setButton;

@property (nonatomic, strong) UILabel * homePageImageLabel;

@property (nonatomic, strong) UIButton * homePageButton;

@property (nonatomic, strong) UIButton * momentButton;

@property (nonatomic, strong) UILabel * nameLabel;
@end
