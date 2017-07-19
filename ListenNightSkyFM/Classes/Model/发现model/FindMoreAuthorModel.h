//
//  FindMoreAuthorModel.h
//  FMMusic
//
//  Created by zyq on 16/1/13.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HomeModel.h"
@interface FindMoreAuthorModel : JSONModel
@property (nonatomic, copy) NSString * code;
@property (nonatomic, strong) NSMutableArray <DianTaiModel> *data;

@end
