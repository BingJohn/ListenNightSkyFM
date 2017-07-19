//
//  SocialModel.h
//  FMMusic
//
//  Created by zyq on 16/1/15.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HomeModel.h"

//@protocol SocialImagesModel
//
//@end
//@interface SocialImagesModel : JSONModel
//
//@end
@protocol SocialDataModel

@end
@interface SocialDataModel : JSONModel

@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * created;
@property (nonatomic, copy) NSString * updated;
@property (nonatomic, copy) NSString * jin;
@property (nonatomic, copy) NSString * commentnum;
@property (nonatomic, copy) NSString * absolute_url;
@property (nonatomic, strong) NSMutableArray * images;
@property (nonatomic, copy) UserModel * user;
@property (nonatomic, copy) NSString * floor;




@end
@interface SocialModel : JSONModel

@property (nonatomic, copy) NSString * code;
@property (nonatomic, strong) NSMutableArray  <SocialDataModel> * data;
@end
