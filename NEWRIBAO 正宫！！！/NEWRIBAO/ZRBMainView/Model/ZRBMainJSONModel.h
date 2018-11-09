//
//  ZRBMainJSONModel.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/28.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface StoriesJSONModel : JSONModel

@property (nonatomic, copy) NSArray * images;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * ga_prefix;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString * title;

@end



@interface ZRBMainJSONModel : JSONModel

@property (nonatomic, copy) NSString * type;
@property (nonatomic, assign) NSInteger  id;
@property (nonatomic, copy) NSArray * images;
@property (nonatomic, copy) NSString * ga_prefix;
@property (nonatomic, copy) NSString * title;


@end


@interface TotalJSONModel : JSONModel

@property (nonatomic, copy) NSString * date;

//解析数据
@property (nonatomic, copy) NSArray <ZRBMainJSONModel *> * top_stories;
@property (nonatomic, copy) NSArray <StoriesJSONModel *> * stories;

@end
NS_ASSUME_NONNULL_END







