//
//  MoreFmViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MoreFmViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>
#import "ZyqTools.h"
#import "MoreModel.h"
@interface MoreFmViewController ()

@end

@implementation MoreFmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)downLoadFromNetIsMore:(BOOL)isMore {
    NSInteger page = 0;
    if (isMore) {
        if (self.dataArray.count %15 ==0) {
            page = self.dataArray.count/15*15;
        }else{
            [self.tableView.mj_footer endRefreshing];
            return;
        }
    }
    __weak typeof(self)weakSelf= self;
    NSString * urlStr = [NSString stringWithFormat:HOTRecommend,self.url,(long)page];
    AFHTTPSessionManager * mananger = [AFHTTPSessionManager manager];
    mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mananger GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MoreModel * moreModel = [[MoreModel alloc]initWithData:responseObject error:nil];
        
        if (isMore) {
            for (HotFmModel * model in moreModel.data) {
                [weakSelf.dataArray addObject:model];
            }
        }else {
            
            [weakSelf.dataArray removeAllObjects];
            for (HotFmModel * model in moreModel.data) {
                [weakSelf.dataArray addObject:model];
            }
        }
        [weakSelf.tableView reloadData];
        isMore ?[weakSelf.tableView.mj_footer endRefreshing] :[weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        isMore ?[weakSelf.tableView.mj_footer endRefreshing] :[weakSelf.tableView.mj_header endRefreshing];
    }];
    
}

@end
