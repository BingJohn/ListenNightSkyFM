//
//  MoreViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MoreViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "MoreModel.h"
#import "ZyqTools.h"
#import "MoreTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "AppDelegate.h"
#import "MusicPlayViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "ZyqTitleLable.h"
#import "AppDelegate+Common.h"
@interface MoreViewController () <UITableViewDataSource, UITableViewDelegate> {

}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:self.titleNmae];
    
    _dataArray = [[NSMutableArray alloc]init];
    [self creatTablView];
    
}

- (void)downLoadFromNetIsMore:(BOOL)isMore {
    NSInteger page = 0;
    if (isMore) {
        if (_dataArray.count %20 ==0) {
            page = _dataArray.count/20*20;
        }else{
            [_tableView.mj_footer endRefreshing];
            return;
        }
    }
    NSString * urlStr = [NSString stringWithFormat:MYSelfDevelopment,_url,page];
    AFHTTPSessionManager * mananger = [AFHTTPSessionManager manager];
    mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mananger GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
      
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MoreModel * moreModel = [[MoreModel alloc]initWithData:responseObject error:nil];
        
        if (isMore) {
            for (HotFmModel * model in moreModel.data) {
                [_dataArray addObject:model];
            }
        }else {
        
            [_dataArray removeAllObjects];
            for (HotFmModel * model in moreModel.data) {
                [_dataArray addObject:model];
            }
        }
        [_tableView reloadData];
        isMore ?[_tableView.mj_footer endRefreshing] :[_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         isMore ?[_tableView.mj_footer endRefreshing] :[_tableView.mj_header endRefreshing];
    }];
}

- (void)creatTablView {
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _tableView .delegate = self;
    _tableView.dataSource =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = TABLECOLOR;
    [self.view addSubview:_tableView];
    [self creatRefresh];
    
}

- (void)creatRefresh {
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downLoadFromNetIsMore:NO];
        
    }];
    _tableView.mj_header = header;
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self downLoadFromNetIsMore:YES];
    }];
    
    _tableView.mj_footer = footer;

    [_tableView.mj_header beginRefreshing];
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    HotFmModel * model = _dataArray[indexPath.row];
    MusicPlayViewController * mpVC = [MusicPlayViewController shareMusicMananger];
    mpVC.musicUrl = model.url;
    mpVC.coverImageUrl = model.cover;
    mpVC.musicTitle = model.title;
    mpVC.musicList = _dataArray;
    mpVC.index = indexPath.row;
    mpVC.isLocal = NO;
    mpVC.diantamodel = nil;
    
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.subtype = @"fromBottom";
    animation.duration=  1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:mpVC animated:YES];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell ==nil) {
        cell = [[MoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.moreModel = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 70;
}

@end
