//
//  ZRBTransitionVerticalPush.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/3.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBTransitionVerticalPush.h"
#import <Masonry.h>
@implementation ZRBTransitionVerticalPush

//转场时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //起始V
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //转场视图控制器
    UIView * containerView = [transitionContext containerView];
    
    //动画
    toVc.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, toVc.view.frame.size.width, toVc.view.frame.size.height);
    [containerView addSubview:toVc.view];
//    [toVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(toVc.view);
//    }];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVc.view.frame = CGRectMake(0, 0, toVc.view.frame.size.width, toVc.view.frame.size.height);
    } completion:^(BOOL finished) {
        BOOL cancelled = transitionContext.transitionWasCancelled;
        // 声明过渡结束
        [transitionContext completeTransition:!cancelled];
    }];
}

@end
