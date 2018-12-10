//
//  ZRBCollectionViewController.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZRBCollectionManager.h"
@interface ZRBCollectionViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray * collectionIdMutArray;

@property (nonatomic, assign) NSString * collectionIdString;

@property (nonatomic, strong) NSMutableArray * idMutArray;

@property (nonatomic, assign) NSIndexPath * indexPath;

@property (nonatomic, strong) NSMutableArray * titleMutArray;

@property (nonatomic, strong) NSMutableArray * imageMutArray;

@property (nonatomic, strong) UITableView * collectionTableView;
- (void)fetchCollectionNewsDataFromCollectionManager;

@end
