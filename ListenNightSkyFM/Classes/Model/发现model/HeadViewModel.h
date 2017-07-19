//
//  HeadViewModel.h
//  FMMusic
//
//  Created by zyq on 16/1/11.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol HeadDataModel


@end
@interface HeadDataModel : JSONModel
@property (nonatomic, copy) NSString * sort;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * flag;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * count;

@end
@interface HeadViewModel : JSONModel

@property (nonatomic, copy) NSString * count;
@property (nonatomic, strong) NSMutableArray <HeadDataModel> * data;
@end
