//
//  ZRBContinerViewController.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/17.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBMessageVView.h"
#import "ZRBMyMessageViewController.h"
@protocol MMenuControllerDelegate <NSObject>

- (void)mmenuContoller:(ZRBMyMessageViewController *)controller didSelectitemAtIndex:(NSUInteger)index;

@end

@interface ZRBContinerViewController : UIViewController

@property (nonatomic, weak) id <MenuControllerDelegate> delegate;

@property (nonatomic, strong) ZRBMyMessageViewController * messageViewController;
- (void)openMueu;
- (void)addMenuViewController;
- (void)addContentControllers;
- (void)openCloseMenu;
@end
