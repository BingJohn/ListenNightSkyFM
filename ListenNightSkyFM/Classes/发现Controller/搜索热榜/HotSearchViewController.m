//
//  HotSearchViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/15.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "HotSearchViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>
#import "ZyqTools.h"
#import "MoreModel.h"
@interface HotSearchViewController ()

@end

@implementation HotSearchViewController

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
    __weak typeof(self) weadSelf = self;
    NSString * urlStr = [NSString stringWithFormat:SEARCHURL,self.url,page];
    AFHTTPSessionManager * mananger = [AFHTTPSessionManager manager];
    mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mananger GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MoreModel * moreModel = [[MoreModel alloc]initWithData:responseObject error:nil];
        
        if (isMore) {
            for (HotFmModel * model in moreModel.data) {
                [weadSelf.dataArray addObject:model];
            }
        }else {
            
            [weadSelf.dataArray removeAllObjects];
            for (HotFmModel * model in moreModel.data) {
                [weadSelf.dataArray addObject:model];
            }
        }
        if (weadSelf.dataArray.count == 0) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 150)];
            label.center = self.view.center;
            label.text = @"没有您搜索的内容哦,换个别的搜索试试";
            label.textColor = [UIColor lightGrayColor];
            label.numberOfLines = 0;
            [self.view insertSubview:label aboveSubview:weadSelf.tableView];
        }
        [weadSelf.tableView reloadData];
        isMore ?[weadSelf.tableView.mj_footer endRefreshing] :[weadSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        isMore ?[weadSelf.tableView.mj_footer endRefreshing] :[weadSelf.tableView.mj_header endRefreshing];
    }];
    
}

@end
