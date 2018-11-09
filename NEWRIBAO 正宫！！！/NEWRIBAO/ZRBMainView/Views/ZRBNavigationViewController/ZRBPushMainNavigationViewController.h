//
//  ZRBPushMainNavigationViewController.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/29.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRBPushMainNavigationViewController : UINavigationController

- (void)addFullScreenPopMainView:(UIViewController *)viewController;

- (void)removeFromFullScreenPopMainView:(UIViewController *)viewController;

@end
