//
//  ZRBCollectionViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCollectionViewController.h"
#import "ZRBNewsTableViewCell.h"
#import <Masonry.h>
#import "SecondaryMessageViewController.h"
#import "ZRBRequestJSONModel.h"

@interface ZRBCollectionViewController ()

@property (nonatomic, strong) ZRBNewsTableViewCell * newsCell;

@end

@implementation ZRBCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //手势返回协议
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    NSLog(@"self.navigationController = %@",self.navigationController);
    _collectionTableView = [[UITableView alloc] init];
    [_collectionTableView registerClass:[ZRBNewsTableViewCell class] forCellReuseIdentifier:@"newsTableView"];
    _collectionTableView.delegate = self;
    _collectionTableView.dataSource = self;
    [self.view addSubview:_collectionTableView];
    [_collectionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.png"]];
    self.navigationController.title = @"收藏";
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"26.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pressBackButton:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self fetchCollectionNewsDataFromCollectionManager];
}

- (void)fetchCollectionNewsDataFromCollectionManager
{
    ZRBCollectionManager * collectionManager = [ZRBCollectionManager sharedManager];
    _collectionIdMutArray = [NSMutableArray arrayWithArray:collectionManager.collectionidMutArray];
    
    _idMutArray = [[NSMutableArray alloc] init];
    _titleMutArray = [[NSMutableArray alloc] init];
    _imageMutArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _collectionIdMutArray.count; i++) {
        _collectionIdString = _collectionIdMutArray[i];
        [[ZRBCollectionManager sharedManager] fetchNewCollectionDataWithidString:_collectionIdString Succeed:^(NSDictionary *newsDict) {
            NSString * idStr = [NSString stringWithFormat:@"%@",[newsDict valueForKey:@"id"]];
            [_idMutArray addObject:idStr];
            NSString * titleStr = [NSString stringWithFormat:@"%@",[newsDict valueForKey:@"title"]];
            NSURL * imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[newsDict valueForKey:@"image"]]];
            NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage * image = [UIImage imageWithData:imageData];
            [_titleMutArray addObject:titleStr];
            [_imageMutArray addObject:image];
            //if ( i == _collectionIdMutArray.count - 1 ){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionTableView reloadData];
                });
           // }
        } error:^(NSError *error) {
            NSLog(@"error错误啦 :   %@",error);
        }];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row = %li",indexPath.row);
    ZRBNewsTableViewCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"newsTableView"];
    if ( cell == nil ){
        cell = [[ZRBNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newsTableView"];
    }
    cell.newsLabel.text = _titleMutArray[indexPath.row];
    cell.newsImageView.image = _imageMutArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( [_titleMutArray isKindOfClass:[NSArray class]] && _titleMutArray.count > 0 ){
        return _titleMutArray.count;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    [self pushToWKWebView];
}

- (void)pushToWKWebView
{
    SecondaryMessageViewController * wkWebController = [[SecondaryMessageViewController alloc] init];
//    ZRBRequestJSONModel * requestJSONModel = [[ZRBRequestJSONModel alloc] init];
//    [requestJSONModel setStr];
//    requestJSONModel.idRequestStr = [NSString stringWithFormat:@"%@",_idMutArray[_indexPath.row]];
    wkWebController.resaveIdString = [NSString stringWithFormat:@"%@",_idMutArray[_indexPath.row]];
    wkWebController.idRequestMutArray = [NSMutableArray arrayWithArray:_idMutArray];
    [self.navigationController pushViewController:wkWebController animated:NO];
}

- (void)pressBackButton:(UIBarButtonItem *)barButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (NSMutableArray *)collectionIdMutArray
//{
//    if ( !_collectionIdMutArray ){
//        _collectionIdMutArray = [[NSMutableArray alloc] init];
//    }
//    return _collectionIdMutArray;
//}

//- (NSMutableArray *)titleMutArray
//{
//    if ( !_titleMutArray ){
//        _titleMutArray = [[NSMutableArray alloc] init];
//    }
//    return _titleMutArray;
//}
//
//- (NSMutableArray *)imageMutArray
//{
//    if ( !_imageMutArray ){
//        _imageMutArray = [[NSMutableArray alloc] init];
//    }
//    return _imageMutArray;
//}

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
