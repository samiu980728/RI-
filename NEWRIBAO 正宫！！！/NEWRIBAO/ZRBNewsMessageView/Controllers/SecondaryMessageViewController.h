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

//代理传值 COntroller层 传值给View层 网络中的信息
@protocol ZRBGiveJSONModelMessageToViewDelegate <NSObject>

- (void) giveJSONModelMessageToView;

@end

@interface SecondaryMessageViewController : UIViewController

// <UIGestureRecognizerDelegate>

@property (nonatomic, strong) ZRBMainWKWebView * mainWebView;

@property (nonatomic, strong) ZRBRequestJSONModel * requestModel;

@property (nonatomic, weak) id <ZRBGiveJSONModelMessageToViewDelegate> delegate;

@end
