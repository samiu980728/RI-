//
//  ZRBCellModel.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/3.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZRBMainJSONModel.h"

@protocol ZRBGiveCellJSONMOdelToMainViewDelegate <NSObject>

- (void)giveCellJSONModelToMainView:(NSMutableArray *)imaMutArray andTitle:(NSMutableArray *)titMutArray;

@end

@interface ZRBCellModel : NSObject

@property (nonatomic, strong) NSMutableArray * anJSONMutArray;

@property (nonatomic, strong) NSMutableArray * tiMutArray;

@property (nonatomic, strong) NSMutableArray * imMutArray;

@property (nonatomic, weak) id <ZRBGiveCellJSONMOdelToMainViewDelegate> delegateCell;

- (void)giveCellJSONModel;

@end
