//
//  ZRBRequestJSONModel.h
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/10/30.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import <WebKit/WebKit.h>
@interface ZRBRequestJSONModel : NSObject

@property (nonatomic, strong) NSDictionary * obj;

@property (nonatomic, copy) NSString * modelStr;

- (void)requestJSONModel;

@end
