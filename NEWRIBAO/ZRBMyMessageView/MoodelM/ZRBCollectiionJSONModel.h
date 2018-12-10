//
//  ZRBCollectiionJSONModel.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/12/6.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "JSONModel.h"

@interface ZRBCollectiionJSONModel : JSONModel

@property (nonatomic, copy) NSString * body;

@property (nonatomic, copy) NSString * image_source;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * image;

@property (nonatomic, copy) NSString * share_url;

@property (nonatomic, copy) NSArray * js;

@property (nonatomic, copy) NSArray * recommenders;

@property (nonatomic, copy) NSString * ga_prefix;

@property (nonatomic, copy) NSDictionary * section;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSArray * css;

//@property (nonatomic, copy) NSArray<Optional> * images;

@end
