//
//  ContentModel.h
//  FMMusic
//
//  Created by zyq on 16/1/10.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HomeModel.h"
@protocol ContentDataModel
@end
@interface ContentDataModel : JSONModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * created;
@property (nonatomic, copy) NSString * created_str;
@property (nonatomic, copy) NSString * zannum;
@property (nonatomic, copy) NSString * replynum;
@property (nonatomic, copy) NSString * role;
@property (nonatomic, copy) NSString * role_id;
//@property (nonatomic, copy) NSString * replyuser;
//@property (nonatomic, copy) NSString * replyobject;
@property (nonatomic, copy) NSString * is_comment;
@property (nonatomic, copy) NSString * is_host_speaker;
//@property (nonatomic, copy) NSString * reply_user;
@property (nonatomic, strong)UserModel *user;


@end

@interface ContentModel : JSONModel
@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * total;
@property (nonatomic, strong) NSMutableArray <ContentDataModel> *data;
@end
