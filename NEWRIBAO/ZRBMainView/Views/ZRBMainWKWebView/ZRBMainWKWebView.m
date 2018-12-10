//
//  ZRBMainWKWebView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMainWKWebView.h"
//@class SecondaryMessageViewController;
//@protocol ZRBGiveJSONModelMessageToViewDelegate
//
//@end

@implementation ZRBMainWKWebView 

- (void)createAndGetJSONModelWKWebView
{

}
    
- (void)recieveNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Dicttongzhi:) name:@"Dicttongzhi" object:nil];
}

- (void)Dicttongzhi:(NSNotification *)noti
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
//        _scrollView.contentSize = CGSizeMake(0, 5000);
//        _scrollView.delegate = self;
        _refresh = YES;
        _flag = 0;
        _webView = [[WKWebView alloc] initWithFrame:self.frame];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        NSLog(@"ZRBMainWKWebView 中的 modelStr ======= %@===== ",_modelStr);
        NSLog(@"_shareUrlString = %@",_shareUrlString);
        WKWebView * wkWebView = [[WKWebView alloc] init];
        [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_shareUrlString]]];
        //[wkWebView loadHTMLString:_modelStr baseURL:nil];
        wkWebView.autoresizingMask = YES;
        wkWebView.scrollView.delegate = self;
        //[self addSubview:wkWebView];
        //[self addSubview:_scrollView];
        [self addSubview:wkWebView];
//        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
        
        [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}

//内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}


/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    
    NSLog(@"navigationResponse.response.URL.host.lowercaseString = %@",navigationResponse.response.URL.host.lowercaseString);
    if ( [navigationResponse.response.URL.host.lowercaseString isEqual:@"https://news-at.zhihu.com/api/4/news/3892357"] ){
        decisionHandler(WKNavigationResponsePolicyAllow);
        return;
    }
    
    decisionHandler(WKNavigationResponsePolicyCancel);
    
}



//先走的是这个方法
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    // 如果请求的是百度地址，则延迟5s以后跳转
    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"https://news-at.zhihu.com/api/4/news/3892357"]) {
        
        //        // 延迟5s之后跳转
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        //            // 允许跳转
        //            decisionHandler(WKNavigationActionPolicyAllow);
        //        });
        
        // 允许跳转
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    // 不允许跳转
    decisionHandler(WKNavigationActionPolicyCancel);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Dicttongzhi" object:nil];
}



@end

