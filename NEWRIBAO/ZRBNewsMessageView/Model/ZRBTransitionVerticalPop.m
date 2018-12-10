//
//  ZRBTransitionVerticalPop.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/3.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBTransitionVerticalPop.h"

@implementation ZRBTransitionVerticalPop
//转场时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    // 起始VC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 目的VC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 转场视图容器
    UIView *containerView = [transitionContext containerView];
    
    //下降动画
    fromVC.view.frame = CGRectMake(0, 0, fromVC.view.frame.size.width, fromVC.view.frame.size.height);
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, fromVC.view.frame.size.width, fromVC.view.frame.size.height);
    } completion:^(BOOL finished) {
        BOOL cancelled = transitionContext.transitionWasCancelled;
        // 声明过渡结束
        [transitionContext completeTransition:!cancelled];
    }];
}
@end
