//
//  MoreModel.h
//  FMMusic
//
//  Created by zyq on 16/1/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HomeModel.h"

@interface MoreUserModel : JSONModel
@property  (nonatomic, copy)NSString * id;
@property  (nonatomic, copy)NSString * nickname;
@property  (nonatomic, copy)NSString * avatar;
@end

@protocol MoreDiantaiModel


@end
@interface MoreDiantaiModel : JSONModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * fmnum;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * viewnum;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * favnum;
@property (nonatomic, strong) MoreUserModel *user;
@end
@protocol  MoreDataModel


@end
@interface MoreDataModel : JSONModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * speak;
@property (nonatomic, copy) NSString * favnum;
@property (nonatomic, copy) NSString * viewnum;
@property (nonatomic, copy) NSString * background;
@property (nonatomic, copy) NSString * is_teacher;
@property (nonatomic, copy) NSString * absolute_url;
//@property (nonatomic, copy) NSString * url_list;
@property (nonatomic, copy) NSString * object_id;
@property (nonatomic, strong)MoreDiantaiModel * diantai;

@end

@interface MoreModel : JSONModel

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSMutableArray <HotFmModel> *data;
@end
