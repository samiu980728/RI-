//
//  ZRBTabBarView.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/19.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRBTabBarView : UIView

@property (nonatomic, strong) UIButton * returnMainViewButton;

@property (nonatomic, strong) UIButton * goNextNewsViewButton;

@property (nonatomic, strong) UIButton * giveApproveButton;

@property (nonatomic, strong) UIButton * shareNewsButton;

@property (nonatomic, strong) UIButton * commentNewsButton;

@property (nonatomic, strong) UILabel * allCommentsLabel;

@property (nonatomic, strong) UILabel * commentsNumLabel;
- (instancetype)initWithFrame:(CGRect)frame andAllapproval:(NSInteger)allApprovalNum andComments:(NSInteger)commentsNum;

@end
