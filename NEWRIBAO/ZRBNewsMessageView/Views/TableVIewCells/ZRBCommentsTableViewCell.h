//
//  ZRBCommentsTableViewCell.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/22.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBLongCommentsJSONModel.h"
@interface ZRBCommentsTableViewCell : UITableViewCell

- (void)changeNumberOfLines;

- (void)zeroToChangeNumberOfLines;

- (void)setMessage:(ZRBCommentsJSONModel *)message;

- (CGFloat)heightForModel:(ZRBCommentsJSONModel *)message;

@property (nonatomic, assign) CGFloat contentSize;

@property (nonatomic, assign) CGFloat timeSize;


@property (nonatomic, assign) CGFloat nameSize;

@property (nonatomic, assign) CGFloat reply_toSize;

@property (nonatomic, assign) CGFloat flodReply_toSize;

@property (nonatomic, strong) UIButton * expandButton;

@property (nonatomic, strong) NSLock * lock;

@property (nonatomic, assign) NSInteger ifSetMessageFlag;

@property (nonatomic, strong) NSMutableArray * AlongHeigtCellMutArray;

@property (nonatomic, strong) NSMutableArray * idMutArray;

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UILabel * avatarImageLabel;

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) UILabel * approvalLabel;

@property (nonatomic, strong) UIButton * approvalButton;

@property (nonatomic, strong) UIImageView * avatarImage;

@property (nonatomic, strong) UILabel * reply_toLabel;

@property (nonatomic, strong) UILabel * reply_toAuthorLabel;

@property (nonatomic, assign) NSInteger numOfLineSNumInt;
@end
