//
//  MoreAuthor.h
//  FMMusic
//
//  Created by zyq on 16/1/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HomeModel.h"


@interface MoreAuthorDataModel : JSONModel

@property (nonatomic, strong) NSMutableArray <DianTaiModel> *tuijian;
@property (nonatomic, strong) NSMutableArray <DianTaiModel> *newlist;
@property (nonatomic, strong) NSMutableArray <DianTaiModel> *hotlist;


@end
@interface MoreAuthor : JSONModel

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) MoreAuthorDataModel * data;
@end
