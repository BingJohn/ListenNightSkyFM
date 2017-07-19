//
//  MoodDetaiModel.h
//  FMMusic
//
//  Created by zyq on 16/1/12.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HomeModel.h"
@interface MoodDetaiModel : JSONModel

@property (nonatomic, copy) NSString * code;
@property (nonatomic, strong) NSMutableArray <HotFmModel> * data;
@end
