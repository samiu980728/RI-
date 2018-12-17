//
//  ZRBOnceUponDataJSONModel.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "JSONModel.h"

@interface ZRBStoriesGoJSONModel : JSONModel

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * ga_prefix;

@property (nonatomic, copy) NSArray * images;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger id;

@end

@interface ZRBOnceUponDataJSONModel : JSONModel

@property (nonatomic, copy) NSString * date;

@property (nonatomic, copy) NSArray <ZRBStoriesGoJSONModel *> * stories;

@end
