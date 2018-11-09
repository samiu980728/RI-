//
//  ZRBMyMessageViewController.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBMessageVView.h"
#import "ZRBMainVIew.h"
#import <Masonry.h>
@interface ZRBMyMessageViewController : UIViewController


@property (nonatomic, strong) ZRBMessageVView * aView;

@property (nonatomic, strong) ZRBMessageVView * bView;

@property (nonatomic, assign) NSInteger iNum;

@property (nonatomic, strong) ZRBMainVIew * MView;

@end
