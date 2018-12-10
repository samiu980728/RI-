//
//  ZRBCommentViewController.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/19.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBCommentView.h"
#import "ZRBCommentManager.h"
#import "ZRBCommentsTableViewHeaderView.h"

@protocol ZRBNumberOfLinesRefreshDelegate  <NSObject>

- (void)fecthRefreshNewNumOfLines:(NSInteger)numberOfLines;

@end


@interface ZRBCommentViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <ZRBNumberOfLinesRefreshDelegate> delegate;

@property (nonatomic, strong) ZRBCommentView * commentView;

@property (nonatomic, strong) NSString * secondResaveIdString;

@property (nonatomic, assign) NSInteger allCommentsNumInteger;

//接收作者
@property (nonatomic, strong) NSMutableArray * authorMutArray;
//接收评论内容
@property (nonatomic, strong) NSMutableArray * contentMMutArray;
//接收用户头像
@property (nonatomic, strong) NSMutableArray * avatorMutArray;
//接收时间
@property (nonatomic, strong) NSMutableArray * timeMutArray;
//接收所回复的消息
@property (nonatomic, strong) NSMutableArray * reply_toMutArray;
//接收作者唯一id
@property (nonatomic, strong) NSMutableArray * onlyIdMutArray;
//接收其他用户给作者的赞数
@property (nonatomic, strong) NSMutableArray * likesMutArray;
//接收长评论回复者
@property (nonatomic, strong) NSMutableArray * shortReplyMutArray;

@property (nonatomic, assign) NSInteger longCommentsNumInteger;

@property (nonatomic, assign) NSInteger shortCommentsNumInteger;

@property (nonatomic, strong) NSMutableArray * allDataMutArray;

@property (nonatomic, assign) NSInteger realLongCommentsInteger;

@property (nonatomic, assign) NSInteger realShortCommentsInteger;

@property (nonatomic, strong) ZRBCommentsTableViewHeaderView * commentsHeaderView;

//短评论

@property (nonatomic, strong) NSMutableArray * allShortDataMutArray;
//接收作者
@property (nonatomic, strong) NSMutableArray * shortAuthorMutArray;
//接收评论内容
@property (nonatomic, strong) NSMutableArray * shortContentMMutArray;
//接收用户头像
@property (nonatomic, strong) NSMutableArray * shortAvatorMutArray;
//接收时间
@property (nonatomic, strong) NSMutableArray * shortTimeMutArray;
//接收作者唯一id
@property (nonatomic, strong) NSMutableArray * shortOnlyIdMutArray;
//接收其他用户给作者的赞数
@property (nonatomic, strong) NSMutableArray * shortLikesMutArray;

//记录组数 给展开与收起cell使用
@property (nonatomic, assign) NSInteger nowSection;

@property (nonatomic, strong) UIButton * selectButton;

@property (nonatomic, assign) NSInteger flag;

@property (nonatomic, assign) NSInteger realRideInteger;

@property (nonatomic, assign) CGFloat contentOffSetYHeight;

@property (nonatomic, assign) NSInteger refreshFlag;

//缓存短评论高度的数组
@property (nonatomic, strong) NSMutableArray * shortCellHeightMutArray;

@property (nonatomic, strong) NSMutableArray * longCommentCellHeightMutArray;

//缓存高度的数组
@property (nonatomic, strong) NSMutableArray * cellHeightMutArray;

//设置行数
@property (nonatomic, assign) NSInteger numOfLinesInteger;

//展开与收起按钮的行数
@property (nonatomic, assign) NSInteger buttonSelectedFlagInteger;

//计算长评论的被回复者评论内容高度
@property (nonatomic, strong) NSMutableArray * longCellHeightMutArray;

@property (nonatomic, strong) NSMutableArray * cellIfRefreshButtonMutArray;

@property (nonatomic, assign) NSInteger oneSectionFlag;

@property (nonatomic, assign) NSInteger twoSectionFlag;

@property (nonatomic, strong) NSMutableArray * buttonSelectedFlagMutArray;

@property (nonatomic, assign) NSInteger isRefreshInteger;

@property (nonatomic, assign) NSInteger isHeaderViewRefreshInteger;

- (void)fenethLongCommentsFromJSONModel;

@end
