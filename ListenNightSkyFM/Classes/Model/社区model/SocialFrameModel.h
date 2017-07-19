//
//  SocialFrameModel.h
//  FMMusic
//
//  Created by zyq on 16/1/15.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SocialModel.h"
@interface SocialFrameModel : NSObject
//头像
@property (nonatomic, assign) CGRect avatarFrame;
//名字
@property (nonatomic, assign) CGRect nickNameFrame;
//评论个数
@property (nonatomic, assign) CGRect commentnumFrame;
//评论图片
@property (nonatomic, assign) CGRect commentnumViewFrame;
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

@property (nonatomic, strong) SocialDataModel * dataModel;
@end
