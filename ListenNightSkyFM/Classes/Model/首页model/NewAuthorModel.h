//
//  NewAuthorModel.h
//  FMMusic
//
//  Created by zyq on 16/1/6.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MoreModel.h"
@interface NewAuthorModel : JSONModel

@property (nonatomic, copy) NSString * code;
@property (nonatomic, strong) NSMutableArray  <MoreDiantaiModel> * data;
@end
