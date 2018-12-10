//
//  ZRBPushMainNavigationViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/29.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBPushMainNavigationViewController.h"

@interface ZRBPushMainNavigationViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray * blackList;

@end

@implementation ZRBPushMainNavigationViewController

//重写可变数组的方法
- (NSMutableArray *)blackList
{
    if ( !_blackList ){
        _blackList = [NSMutableArray array];
    }
    return _blackList;
}

- (void)addFullScreenPopMainView:(UIViewController *)viewController
{
    if ( !viewController ){
        return;
    }
    [self.blackList addObject:viewController];
}

- (void)removeFromFullScreenPopMainView:(UIViewController *)viewController
{
    for (UIViewController * vc in self.blackList) {
        if ( vc == viewController ){
            [self.blackList removeObject:vc];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //  这句很核心 稍后讲解
    id target = self.interactivePopGestureRecognizer.delegate;
    //  这句很核心 稍后讲解
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    //  获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    //  创建pan手势 作用范围是全屏
    UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
}

#pragma mark - UIGestureRecognizerDelegate
//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // 根据具体控制器对象决定是否开启全屏右滑返回
    for (UIViewController *viewController in self.blackList) {
        if ([self topViewController] == viewController) {
            return NO;
        }
    }
    
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // 解决右滑和UITableView左滑删除的冲突
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return self.childViewControllers.count == 1 ? NO : YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
