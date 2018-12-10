//
//  ZRBMainWKWebView.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import <JSONModel.h>
#import <WebKit/WebKit.h>

//@class SecondaryMessageViewController;
//@protocol ZRBGiveJSONModelMessageToViewDelegate
//
//@end

@interface ZRBMainWKWebView : UIView

<WKNavigationDelegate, WKUIDelegate, UIGestureRecognizerDelegate,UIScrollViewDelegate>



@property (nonatomic, strong) WKWebView * webView;

@property (nonatomic, strong) WKUserContentController * userContentController;

//解析JSONModel
@property (nonatomic, strong) NSDictionary * obj;

@property (nonatomic, strong) NSMutableArray * JSONModelMut;

@property (nonatomic, copy) NSString * modelStr;

@property (nonatomic, strong) UIImageView * snakeImageView;

@property (nonatomic, strong) UIPanGestureRecognizer * panGestureRecognizer;

@property (nonatomic, copy) NSString * shareUrlString;

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, assign) BOOL refresh;

@property (nonatomic, assign) NSInteger flag;
- (void)createAndGetJSONModelWKWebView;

- (void)recieveNotification;

@end
