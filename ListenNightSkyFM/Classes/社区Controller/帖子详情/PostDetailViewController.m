//
//  PostDetailViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/16.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "PostDetailViewController.h"
#import "MainPostTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "ZyqTools.h"
#import "ContentOneModel.h"
#import "ContentFrameModel.h"
#import "MinorPostTableViewCell.h"
#import "ContentTwoFrameModel.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface PostDetailViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSString * _contentUrlKey;
 
    UITableView *_tableView;
    AFHTTPSessionManager * _mananger;
    
    

}
@property (nonatomic, strong) NSMutableArray * mainArray;
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (strong, nonatomic)  MBProgressHUD * hudProgress;
@end

@implementation PostDetailViewController


//懒加载

- (NSMutableArray *)mainArray {
    if (_mainArray == nil) {
        _mainArray = [[NSMutableArray alloc]init];
    }
    return _mainArray;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"社区详情"];
    
    [self creatTablView];
   
    [self creatMananger];
     [self downLoadFromeNetisMore:NO];
    _hudProgress = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_hudProgress];
    _hudProgress.mode = MBProgressHUDModeIndeterminate;
}

- (void)creatMananger {
    _mananger = [AFHTTPSessionManager manager];
    _mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self refreshView];
}

- (void)refreshView {
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downLoadFromeNetisMore:NO];
        
    }];
    _tableView.mj_header = header;
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self downLoadFromeNetisMore:YES];
        
    }];
    
    _tableView.mj_footer = footer;
    
    [_tableView.mj_header beginRefreshing];

}


- (void)downLoadFromeNetisMore :(BOOL)isMore {
    
    if (!_contentUrlKey) {
        return;
    }
    NSInteger page = 0;
    if (isMore) {
        if (_dataArray.count % 10 == 0) {
            page = _dataArray.count /10 *10;
        }else{
            [_tableView.mj_footer endRefreshing];
            return;
        }
    }
    __weak typeof(self) weakSelf = self;
    NSString * str1 = [NSString stringWithFormat:COMMENT2,_contentUrlKey,page];
    [_mananger GET:str1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ContentOneModel * content1Model = [[ContentOneModel alloc]initWithData:responseObject error:nil];
        
        //
        ContentFrameModel * frameModle = [[ContentFrameModel alloc]init];
        frameModle.postModel = content1Model.post;
//        需要给第一个cell 加一个判断条件
        if (content1Model.post != nil) {
              [weakSelf.mainArray addObject:frameModle];
        }
      
        if (isMore) {
            
            
            for (SocialDataModel * dataModel in content1Model.data) {
                
                ContentTwoFrameModel * contentTwoFrame =[[ContentTwoFrameModel alloc]init];
                contentTwoFrame.dataModel = dataModel;
                [_dataArray addObject:contentTwoFrame];
            }
            

        }else {
            [_dataArray removeAllObjects];
            
            for (SocialDataModel * dataModel in content1Model.data) {
                
                ContentTwoFrameModel * contentTwoFrame =[[ContentTwoFrameModel alloc]init];
                contentTwoFrame.dataModel = dataModel;
                [_dataArray addObject:contentTwoFrame];
            }

        }
        
        [_tableView reloadData];
        isMore ?[_tableView.mj_footer endRefreshing]: [_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        isMore ?[_tableView.mj_footer endRefreshing]: [_tableView.mj_header endRefreshing];
        
    }];


}
- (void)creatTablView {
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _tableView .delegate = self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MainPostTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id0"];
        if (cell == nil) {
            cell = [[MainPostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id0"];
        }
        if (_mainArray.count) {
        cell.frameModel = _mainArray[indexPath.row];
        }
        
        return cell;
    }else {
        MinorPostTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id2"];
        if (cell == nil) {
            cell = [[MinorPostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id2"];
        }
        cell.fuckBlock = ^(BOOL wasFucking){
        
            if (wasFucking) {
                _hudProgress.labelText = @"举报成功,正在审核~";
                [_hudProgress show:YES];
                [_hudProgress hide:YES afterDelay:1];
            }
        };
        if (_dataArray.count) {
            cell.dataFrame = _dataArray[indexPath.row - 1];
        }
        
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray && self.mainArray ) {
        return self.dataArray.count + self.mainArray.count -1;
    }
    return 1;
}
- (void)setDataModel:(SocialDataModel *)dataModel {
    _dataModel = dataModel;
    _contentUrlKey = _dataModel.id;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ContentFrameModel * frameModel = _mainArray[indexPath.row];
        return frameModel.cellHeight+10;
    }else {
        ContentTwoFrameModel * model2 = _dataArray[indexPath.row-1];
        return model2.cellHeight+10;
    }
}

@end
