//
//  ZRBContinerViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/17.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBContinerViewController.h"
#import "ZRBMyMessageViewController.h"
#import "ZRBMainViewController.h"
#import "ZRBCollectionViewController.h"
@interface ZRBContinerViewController ()<MenuControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) ZRBMyMessageViewController * myMessageViewController;

@property (nonatomic, strong) UINavigationController * navController;

//存放和记录当前呈现的主控制器界面
@property (nonatomic, strong) UIViewController* contentController;

//记录容器控制器中有多少个这样的界面
@property (nonatomic, strong) NSArray * viewControllersArray;

//记录当前菜单是否打开
@property (nonatomic, assign) BOOL isMenuOpen;

//记录视图控制器在数组中的位置
@property (nonatomic, assign) NSUInteger controllerIndexInteger;

//判断动画是否在执行
@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation ZRBContinerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    [self addMenuViewController];
    [self addContentControllers];
}

- (void)addContentControllers
{
    ZRBMainViewController * mainController = [[ZRBMainViewController alloc] init];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:mainController];
    
//    [self setViewControllersArray:@[navController]];
    //创建菜单控制器
    self.myMessageViewController = [[ZRBMyMessageViewController alloc]init];
    self.myMessageViewController.view.backgroundColor = [UIColor whiteColor];
    
   UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:self.myMessageViewController];
    NSLog(@"self.myMessageViewController.navigationController = %@",self.myMessageViewController.navigationController);
    //下面这两条差不多
    [self addChildViewController:self.myMessageViewController];
    [self.view addSubview:self.myMessageViewController.view];
    
    [self setViewControllersArray:@[navController,nav]];
    [self setContentController:navController];

    //此为视图控制器
    self.navController.delegate = self;
    self.myMessageViewController.delegate = self;
}

- (void)openMueu
{
//    ZRBCollectionViewController * collViewController = [[ZRBCollectionViewController alloc] init];
//    NSLog(@"123self.navigationController = %@",self.navigationController);
//    [self.navigationController pushViewController:collViewController animated:YES];
}
//重写 完成主界面视图的添加和移除
- (void)setContentController:(UIViewController *)contentController
{
    if ( _contentController == contentController ){
        return;
    }
    
    //解决内容控制器起始坐标不一致
    if ( _contentController ){
        contentController.view.transform = _contentController.view.transform;
    }
    
    
    [_contentController willMoveToParentViewController:nil];
    [_contentController.view removeFromSuperview];//移除旧的视图
    [_contentController removeFromParentViewController];//解除父子控制器的关系
    
    //增添传进来的视图
    _contentController = contentController;
    [self addChildViewController:contentController];
    [self.view addSubview:contentController.view];
}

//封装菜单界面
- (void)addMenuViewController
{
//    //创建菜单控制器
//    [self setMyMessageViewController:[[ZRBMyMessageViewController alloc]init]];
//
//    [self setNavController:[[UINavigationController alloc] initWithRootViewController:self.myMessageViewController]];
//
//#pragma mark 加这两句话 就能打印出来 证明 messageVIewCOntroller的UINavigationController存在
//
////    [self addChildViewController:self.navController];
////    [self.view addSubview:self.myMessageViewController.view];
//
//    //下面这两条差不多
//    [self addChildViewController:self.myMessageViewController];
//    [self.view addSubview:self.myMessageViewController.view];
//
//    //此为视图控制器
//    self.navController.delegate = self;
//    self.myMessageViewController.delegate = self;
}
- (void)pressMainNewsButton:(UIButton *)sender
{
    NSLog(@"123123213");
}
//根据打开的状态判断动画的走向
//侧边按钮的动画
- (void)openCloseMenu
{
    if ( _isAnimating ){
        return;
    }

    [UIView animateWithDuration:0.15 animations:^{
        _isAnimating = YES;
        if ( !_isMenuOpen ){
            //相对位移函数
            //以在屏幕上的初始位移为基准
            self.myMessageViewController.view.transform = CGAffineTransformMakeTranslation(320, 0);
            self.contentController.view.transform = CGAffineTransformMakeTranslation(320, 0);
        }else{
            self.myMessageViewController.view.transform = CGAffineTransformMakeTranslation(320, 0);
            self.contentController.view.transform = CGAffineTransformMakeTranslation(320, 0);
        }
    }completion:^(BOOL finished) {
        _isMenuOpen = !_isMenuOpen;
        //根据角标设置控制器
        if ( [self.viewControllersArray isKindOfClass:[NSArray class]] && _viewControllersArray.count > 0 ){
        [self setContentController:self.viewControllersArray[_controllerIndexInteger]];
        }
        if ( !_isMenuOpen ){
            [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                //把myMessageViewController 控制的视图还原到原坐标位置： -320, 0
                self.myMessageViewController.view.transform = CGAffineTransformIdentity;
                self.contentController.view.transform = CGAffineTransformIdentity;//对视图进行还原
            } completion:^(BOOL finished) {
                //通过找与父视图的关系 进行点击菜单跳转界面
                _isAnimating = NO;
            }];
        }else{
            _isAnimating = NO;
        }
    }];
}

//代理方法实现
- (void)menuContoller:(ZRBMyMessageViewController *)controller didSelectitemAtIndex:(NSUInteger)index
{
    //这相当于通过set方法 给ControllerIndexInteger 赋值
    [self setControllerIndexInteger:index];
    
    [self openCloseMenu];
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
