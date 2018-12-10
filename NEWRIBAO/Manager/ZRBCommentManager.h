//
//  ZRBCommentManager.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/19.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZRBNewsAdditionalJSONModel.h"
#import "ZRBLongCommentsJSONModel.h"
typedef void(^ZRBGetAdditionalJSONModelHandle)(ZRBNewsAdditionalJSONModel * additionalJSONModel);

typedef void(^ErrorHandle)(NSError * error);

typedef void(^ZRBGetLongCommentJSONModelHandle)(ZRBLongCommentsJSONModel * longCommentsJSONModel);

@interface ZRBCommentManager : NSObject

@property (nonatomic, assign) NSInteger longCommentsNumInteger;

@property (nonatomic, assign) NSInteger approveNumInteger;

@property (nonatomic, assign) NSInteger shortCommentsNumInteger;

@property (nonatomic, assign) NSInteger allCommnetsNumInteger;

@property (nonatomic, strong) NSLock * lock;
//hi使用网络请求得到数据
- (void)fetchCommentsNumDataFormNewsViewWithIdString:(NSString *)idString Succeed:(ZRBGetAdditionalJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock;

- (void)fetchLongLongCommentsDataFromNewsViewWith:(NSString *)idString Succeed:(ZRBGetLongCommentJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock;
//短评论请求
- (void)fetchShortShortCommentsDataFromNewsWith:(NSString *)idString Succeed:(ZRBGetLongCommentJSONModelHandle)succeedBlock error:(ErrorHandle)errorBlock;

+ (instancetype)sharedManager;
@end
