//
//  ContentFrame.h
//  FMMusic
//
//  Created by zyq on 16/1/10.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentModel.h"
#import <UIKit/UIKit.h>
@interface ContentFrame : NSObject

@property (nonatomic, strong) ContentDataModel * modelFrame;
@property (nonatomic, assign) CGRect nickNameFrame;
@property (nonatomic, assign) CGRect avatarFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect createdFrame;

@property (nonatomic, assign) CGFloat cellHeight;


@end
