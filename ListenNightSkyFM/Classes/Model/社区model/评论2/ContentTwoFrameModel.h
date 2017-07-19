//
//  ContentTwoFrameModel.h
//  FMMusic
//
//  Created by zyq on 16/1/16.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SocialModel.h"
@interface ContentTwoFrameModel : NSObject

@property (assign, nonatomic)  CGRect avatarViewFrame;
@property (assign, nonatomic)  CGRect floorCountFrame;
@property (assign, nonatomic)  CGRect nickNameFrame;
@property (assign, nonatomic)  CGRect contentFrame;

@property (assign, nonatomic)  CGRect timeLableFrame;

@property (assign, nonatomic) CGFloat cellHeight;

@property (nonatomic, strong) SocialDataModel * dataModel;

@end
