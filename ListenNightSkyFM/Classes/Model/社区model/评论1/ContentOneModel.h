//
//  ContentOneModel.h
//  FMMusic
//
//  Created by zyq on 16/1/16.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "SocialModel.h"
@interface ContentOneModel : JSONModel

@property (nonatomic, copy) NSString * code;

@property (nonatomic, copy) SocialDataModel * post;

@property (nonatomic, strong) NSMutableArray  <SocialDataModel > *data;
@end
