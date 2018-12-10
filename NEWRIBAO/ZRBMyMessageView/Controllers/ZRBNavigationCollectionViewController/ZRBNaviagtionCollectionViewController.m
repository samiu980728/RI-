//
//  ZRBNaviagtionCollectionViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/7.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBNaviagtionCollectionViewController.h"

@interface ZRBNaviagtionCollectionViewController ()

@end

@implementation ZRBNaviagtionCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    ZRBCollectionViewController * collectionViewController = [ZRBCollectionViewController sharedViewController];
    self.navigationController.navigationBar.hidden = YES;
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
