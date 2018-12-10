//
//  ZRBMyMessageViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBMyMessageViewController.h"
#import <Masonry.h>
#import "ZRBContinerViewController.h"
@interface ZRBMyMessageViewController ()

@end

@implementation ZRBMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled = YES;
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
//    _navController = [[UINavigationController alloc] initWithRootViewController:self];
//    _navController.title = @"你好";
    _iNum = 0 ;
    ZRBMessageVView * messageView = [[ZRBMessageVView alloc] init];
    //ZRBMessageVView * messageView = [[ZRBMessageVView alloc] initWithFrame:CGRectMake(-320, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    messageView.userInteractionEnabled = YES;
    messageView.backgroundColor = [UIColor whiteColor];

//    messageView.frame = CGRectMake(-320, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //messageView.frame = CGRectMake(-320, 0, 320, [UIScreen mainScreen].bounds.size.height);
//    messageView.mainNewsButton.backgroundColor = [UIColor blackColor];
    messageView.mainNewsButton.tag = 1;
    [messageView.mainNewsButton addTarget:self action:@selector(pressMainNewsButton:) forControlEvents:UIControlEventTouchUpInside];
    [messageView.collectionButton addTarget:self action:@selector(pressCollectionButton:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:messageView];
    
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(320);
    }];
    self.view.frame = CGRectMake(-320, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (void)initWithMessageView
{
    
}

- (void)dealloc
{
    NSLog(@"@视图销毁");
}

- (void)pressCollectionButton:(UIButton *)idSender
{
    ZRBCollectionViewController * controller = [[ZRBCollectionViewController alloc] init];
        UINavigationController * naviagtionController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:naviagtionController animated:YES completion:nil];
#pragma mark 然后dimiss回去 然后再用数据交互把收藏界面弄出来
    
//    UINavigationController * naviagtionController = [[UINavigationController alloc] initWithRootViewController:self];
//    NSLog(@"naviagtionController.parentViewController = %@",naviagtionController.parentViewController);
//    [self performSelector:@selector(openMueu)];
}

- (void)openMueu
{
    ZRBCollectionViewController * collViewController = [[ZRBCollectionViewController alloc] init];
    NSLog(@"12345678self.navigationController = %@",self.navigationController);
    [self.navigationController pushViewController:collViewController animated:YES];
}

- (UIViewController *)getCurrentVC
{
    UIViewController * result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if ( window.windowLevel != UIWindowLevelNormal ){
        NSArray * windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if ( tmpWin.windowLevel == UIWindowLevelNormal ){
                window = tmpWin;
                break;
            }
        }
    }
    UIView * frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ( [nextResponder isKindOfClass:[UIViewController class]] ){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return result;
}


- (void)pressMainNewsButton:(UIButton *)sender
{
    //判断是否响应这个代理方法
    if ([self.delegate respondsToSelector:@selector(menuContoller:didSelectitemAtIndex:)]){
        [self.delegate menuContoller:self didSelectitemAtIndex:sender.tag-1];
    }
}

- (void)addMenuItems
{
    UIButton * mainNewsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainNewsButton setTitle:@"首页" forState:UIControlStateNormal];
    mainNewsButton.titleLabel.font = [UIFont systemFontOfSize:20];
    mainNewsButton.tag = 1;
    mainNewsButton.backgroundColor = [UIColor whiteColor];
    [mainNewsButton addTarget:self action:@selector(menuItemselected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mainNewsButton];
    [mainNewsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(40);
    }];
}

//选中菜单
- (void)menuItemselected:(UIButton *)sender
{
    NSLog(@"22333333333");
    //判断是否响应这个代理方法
    if ([self.delegate respondsToSelector:@selector(menuContoller:didSelectitemAtIndex:)]){
        [self.delegate menuContoller:self didSelectitemAtIndex:sender.tag-1];
    }
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

