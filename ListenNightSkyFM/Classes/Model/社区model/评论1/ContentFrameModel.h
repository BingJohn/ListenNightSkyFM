//
//  ContentFrameModel.h
//  FMMusic
//
//  Created by zyq on 16/1/16.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ContentOneModel.h"
@interface ContentFrameModel : NSObject
//头像
@property (nonatomic, assign) CGRect avatarFrame;
//名字
@property (nonatomic, assign) CGRect nickNameFrame;

//时间
@property (nonatomic, assign) CGRect timeFrame;
//标题
@property (nonatomic, assign) CGRect titleFrame;
//内容
@property (nonatomic, assign) CGRect contentFrame;

//图片尺寸
@property (nonatomic, assign) CGRect imageViewFrame;

//cell 高度
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) SocialDataModel * postModel;
@end
