//
//  MusicPlayViewController.h
//  FMMusic
//
//  Created by zyq on 16/1/7.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "BaseViewController.h"


#import "HomeModel.h"

@interface MusicPlayViewController : BaseViewController

// 旋转的头像连接
@property (nonatomic, copy) NSString * coverImageUrl;

//音乐播放连接
@property (nonatomic, copy) NSString * musicUrl;

//节目介绍
@property (nonatomic, copy) NSString * musicTitle;

//节目清单
@property (nonatomic, strong) NSMutableArray * musicList;

@property (nonatomic, assign) NSInteger index;

// 有一种情况下 音乐播放器中的controller 下面的tableview 没有数据， 单独考虑出来
@property (nonatomic, strong) DianTaiModel * diantamodel;

@property (nonatomic, assign) BOOL isLocal;
+ (MusicPlayViewController *)shareMusicMananger;



@end
