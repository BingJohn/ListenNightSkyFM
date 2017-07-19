//
//  HomeModel.h
//  FMMusic
//
//  Created by lujh on 17/4/3.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>



@interface NewFmUser : JSONModel

@property  (nonatomic, copy)NSString * id;
@property  (nonatomic, copy)NSString * nickname;
@property  (nonatomic, copy)NSString * avatar;

@end

@protocol NewFmDitanTaiModel

@end
@interface NewFmDitanTaiModel : JSONModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * fmnum;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * viewnum;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * favnum;
@property (nonatomic, strong) NewFmUser *user;
@end
@protocol NewFm 

@end

//新fm
@interface NewFm : JSONModel
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
@property (nonatomic, strong)NewFmDitanTaiModel * diantai;
@end

@interface UserModel : JSONModel
@property  (nonatomic, copy)NSString * id;
@property  (nonatomic, copy)NSString * nickname;
@property  (nonatomic, copy)NSString * avatar;

@end
@protocol DianTaiModel


@end
//热门FM的一个数组
@interface DianTaiModel : JSONModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * fmnum;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * viewnum;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * favnum;
@property (nonatomic, strong) UserModel *user;


@end
//热门fm
@protocol HotFmModel <NSObject>


@end
@interface HotFmModel : JSONModel
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
@property (nonatomic, copy) NSString * object_id;
@property (nonatomic, strong)DianTaiModel * diantai;


@end
//种类
@protocol CateGoryModel


@end
@interface CateGoryModel : JSONModel

@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * sort;
@property (nonatomic, copy) NSString * flag;

@end
//tuijian
@protocol TuiJianModel

@end
@interface TuiJianModel : JSONModel

@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * value;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * sort;
@end

//dataModel 里面全是数组
@interface DataModel : JSONModel
@property (nonatomic, strong) NSMutableArray  <TuiJianModel> * tuijian;
@property (nonatomic, strong) NSMutableArray  <CateGoryModel>* category;
@property (nonatomic, strong) NSMutableArray  <HotFmModel>   * hotfm;
@property (nonatomic, strong) NSMutableArray    <NewFm>      * newfm;
@property (nonatomic, strong) NSMutableArray    <NewFm>      * newlesson;
@property (nonatomic, strong) NSMutableArray    <NewFmDitanTaiModel> *diantai;

@end
@interface HomeModel : JSONModel

@property (nonatomic, copy) NSString * code;
@property (nonatomic, strong) DataModel * data;

@end
