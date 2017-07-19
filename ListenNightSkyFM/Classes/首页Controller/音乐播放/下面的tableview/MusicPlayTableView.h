//
//  MusicPlayTableView.h
//  FMMusic
//
//  Created by zyq on 16/1/10.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface MusicPlayTableView : UITableView 

@property (nonatomic, copy) NSString * picUrl;
@property (nonatomic, copy) NSString * favnum;
@property (nonatomic, copy) NSString * viewnum;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * contentUrl;
@property (nonatomic, assign) BOOL isKey;
@property (nonatomic, copy) NSString * authorKey;
@property (nonatomic, strong) DianTaiModel * diantaiModel;

+ (MusicPlayTableView *)shareMusicPlayTableViewWithFrame:(CGRect)frame WithStyle:(UITableViewStyle)style;
@end
