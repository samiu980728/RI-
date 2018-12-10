//
//  ZRBLongCommentsJSONModel.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/20.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "JSONModel.h"

@interface ZRBReplyToJSONModel : JSONModel

@property (nonatomic, copy) NSString * content;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString * author;

@end

@interface ZRBCommentsJSONModel : JSONModel

@property (nonatomic, copy) NSString * author;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * avatar;

@property (nonatomic, assign) NSInteger * time;

@property (nonatomic, copy) NSArray <ZRBReplyToJSONModel *> * reply_to;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger likes;

@end

@interface ZRBLongCommentsJSONModel : JSONModel

//数组的每个单元都是一个字典
@property (nonatomic, copy) NSArray <ZRBCommentsJSONModel *> * comments;

@end
