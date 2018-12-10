//
//  SecondaryMessageViewController.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBMainWKWebView.h"
#import <Masonry.h>
#import "ZRBRequestJSONModel.h"
#import "ZRBTabBarView.h"
#import "ZRBCommentManager.h"
#import "ZRBCoordinateMananger.h"
#import "ZRBCommentViewController.h"
#import "ZRBTransitionVerticalPush.h"
#import "ZRBTransitionVerticalPop.h"
#import "ZRBApprovalAnimationView.h"
#import "ZRBSharedView.h"

#import "ZRBCollectionViewController.h"
#import "ZRBCollectionManager.h"
//代理传值 COntroller层 传值给View层 网络中的信息
@protocol ZRBGiveJSONModelMessageToViewDelegate <NSObject>

- (void) giveJSONModelMessageToView;

@end

@protocol ZRBGiveIdCollectionToViewControllerDelegate <NSObject>

- (void) giveIdCollectionToViewController:(NSString *)idString;

@end


@interface SecondaryMessageViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) ZRBCollectionViewController * collectionController;

@property (nonatomic, weak) id <ZRBGiveIdCollectionToViewControllerDelegate> collectionDelegete;

@property (nonatomic, strong) ZRBMainWKWebView * mainWebView;

@property (nonatomic, strong) ZRBRequestJSONModel * requestModel;

@property (nonatomic, weak) id <ZRBGiveJSONModelMessageToViewDelegate> delegate;

@property (nonatomic, copy) NSString * resaveIdString;

@property (nonatomic, strong) ZRBTabBarView * tabBarView;

//总评论数量与点赞数量
@property (nonatomic, assign) NSInteger allsApprovalInteger;

@property (nonatomic, assign) NSInteger allsCommentsInteger;

@property (nonatomic, assign) NSInteger allLongCommentsInteger;

@property (nonatomic, assign) NSInteger allShortCommentsInteger;

@property (nonatomic, strong) ZRBCommentViewController * commentVIewController;

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) NSMutableArray * idRequestMutArray;

@property (nonatomic, assign) BOOL refresh;
- (void)fenethCommentsNumFromCommentManagerBlock;
@end
