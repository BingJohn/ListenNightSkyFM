//
//  MoreViewController.h
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "BaseViewController.h"

@interface MoreViewController : BaseViewController
//拼接的id
@property (nonatomic, copy) NSString * url;

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, copy) NSString * titleStr;
@property (nonatomic, copy) NSString * titleNmae;
@end
