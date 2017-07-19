//
//  MoreAuthorViewController.h
//  FMMusic
//
//  Created by zyq on 16/1/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@class MoreAuthorHeadView;
@interface MoreAuthorViewController : UIViewController

@property (nonatomic, copy)NSString * url;

@property (nonatomic ,strong) DianTaiModel * dianTaiModel;

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIVisualEffectView * effectView;

@property (nonatomic,assign)CGFloat headerImgHeight;
@property (nonatomic,assign)CGFloat iconHeight;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) MoreAuthorHeadView * headView;
@property (nonatomic, strong) UITableView * tableView;
@end
