//
//  ZRBShortCommentsJSONModel.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/24.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "JSONModel.h"

@interface ZRBShortShortCommentsJSONModel: JSONModel

@property (nonatomic, copy) NSString * author;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, assign) NSInteger likes;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, copy) NSString * avatar;

@end

@interface ZRBShortCommentsJSONModel : JSONModel

@property (nonatomic, copy) NSArray <ZRBShortShortCommentsJSONModel *> * comments;

@end
