//
//  ZRBApprovalAnimationView.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/3.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBApprovalAnimationView.h"
#import <Masonry.h>
@implementation ZRBApprovalAnimationView 

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.png"]];
        self.approvalLabel = [[UILabel alloc] init];
        [self addSubview:self.approvalLabel];
    
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.approvalLabel.font = [UIFont systemFontOfSize:15];
    self.approvalLabel.text = @"155";
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform."];
//    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"position"];
//    ani.fromValue = [NSValue valueWithBytes:&myString objCType:@encode(char *)];
//    ani.toValue = [NSValue valueWithBytes:&toString objCType:@encode(char *)];
//    ani.removedOnCompletion = NO;
//    ani.fillMode = kCAFillModeForwards;
    //创建动画效果类
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.7;
#pragma mark transition.removedOnCompletion 方法
    
    
    
    
    
//    transition.removedOnCompletion = NO;
    //设置动画淡入淡出的效果
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    
    [self.layer addAnimation:transition forKey:nil];
    [self.approvalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
