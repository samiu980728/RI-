//
//  ZRBCellModel.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/3.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCellModel.h"

@implementation ZRBCellModel


- (void)giveCellJSONModel
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
}

- (void)tongzhi:(NSNotification *)noti
{
    _tiMutArray = [[NSMutableArray alloc] init];
    _imMutArray = [[NSMutableArray alloc] init];
    _anJSONMutArray = [NSMutableArray arrayWithArray:noti.userInfo[@"one"]];
    for (int i = 0; i < _anJSONMutArray.count; i++) {
        ZRBMainJSONModel * tiJSONModel = [[ZRBMainJSONModel alloc] init];
        tiJSONModel = _anJSONMutArray[i];
        
        [_tiMutArray addObject:tiJSONModel.title];
        
        NSURL * JSONUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",tiJSONModel.images[0]]];
        
        NSData * imageData = [NSData dataWithContentsOfURL:JSONUrl];
        
        UIImage * image = [UIImage imageWithData:imageData];
        if ( image ){
            [_imMutArray addObject:image];
        }
    }
    //已经请求到网络数据 启用代理
    if ( [_delegateCell respondsToSelector:@selector(giveCellJSONModelToMainView:andTitle:)] ){
        [_delegateCell giveCellJSONModelToMainView:_imMutArray andTitle:_tiMutArray];
    }
    
}

@end
