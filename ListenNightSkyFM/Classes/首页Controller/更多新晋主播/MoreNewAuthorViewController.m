//
//  MoreNewAuthorViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/6.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MoreNewAuthorViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "ZyqTools.h"
#import "NewAuthorModel.h"
#import "HotFMAuthorDetailTableViewCell.h"
#import "MoreAuthorViewController.h"
#import "AppDelegate.h"
@interface MoreNewAuthorViewController ()

@end

@implementation MoreNewAuthorViewController


- (void)downLoadFromNetIsMore:(BOOL)isMore {
    NSInteger page = 0;
    if (isMore) {
        if (self.dataArray.count %20 ==0) {
            page = self.dataArray.count/20*20;
        }else{
            [self.tableView.mj_footer endRefreshing];
            return;
        }
    }
    __weak typeof(self)weakSelf= self;
    NSString * urlStr = [NSString stringWithFormat:NewAuthorUrl,(long)page];
    AFHTTPSessionManager * mananger = [AFHTTPSessionManager manager];
    mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mananger GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NewAuthorModel * newModel  = [[NewAuthorModel alloc]initWithData:responseObject error:nil];
        
        if (isMore) {
            for (MoreDiantaiModel * model in newModel.data) {
                [weakSelf.dataArray addObject:model];
            }
        }else {
            
            [weakSelf.dataArray removeAllObjects];
            for (MoreDiantaiModel * model in newModel.data) {
                [weakSelf.dataArray addObject:model];
            }
        }
        [weakSelf.tableView reloadData];
        isMore ?[weakSelf.tableView.mj_footer endRefreshing] :[weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        isMore ?[weakSelf.tableView.mj_footer endRefreshing] :[weakSelf.tableView.mj_header endRefreshing];
    }];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    DianTaiModel * model = self.dataArray[indexPath.row];
    NSString * urlKey = model.id;
    MoreAuthorViewController * moreAuVC = [[MoreAuthorViewController alloc]init];
    moreAuVC.dianTaiModel = model;
    moreAuVC.url = urlKey;
    [self.navigationController pushViewController:moreAuVC animated:YES];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotFMAuthorDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell ==nil) {
        cell = [[HotFMAuthorDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
