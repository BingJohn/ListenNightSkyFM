//
//  SocialViewController.m
//  FMMusic
//
//  Created by lujh on 17/4/3.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "SocialViewController.h"
#import "ZyqTools.h"
#import <AFNetworking/AFNetworking.h>
#import "SocialModel.h"
#import "SocialFrameModel.h"
#import "SocialTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "PostDetailViewController.h"
@interface SocialViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISegmentedControl * segentedControl;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, copy)   NSString * url;
@property (nonatomic, strong) AFHTTPSessionManager * mananger;

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"社区"];
    
    _dataArray = [[NSMutableArray alloc]init];
    _url = SCROIALESSENCE;
    [self createSegementCT];
    [self createTableView];
    [self refresh];
    
}

- (void)refresh {
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

- (void)downLoadFromeNetisMore:(BOOL)isMore {
    NSInteger page = 0;
    if (isMore) {
        if (_dataArray.count %10 ==0) {
            page = _dataArray.count/10*10;
        }else{
            [_tableView.mj_footer endRefreshing];
            return;
        }
    }
    
    if (_mananger == nil) {
        _mananger = [AFHTTPSessionManager manager];
        _mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    if (!_url) {
        return;
    }
    NSString * str = [NSString stringWithFormat:_url,page];
    [_mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SocialModel * model = [[SocialModel alloc]initWithData:responseObject error:nil];
        
        if (isMore) {
            for (SocialDataModel * dataModel in model.data ) {
                SocialFrameModel * frameModel = [[SocialFrameModel alloc]init];
                frameModel.dataModel = dataModel;
                [_dataArray addObject:frameModel];
            }
        }else {
            [_dataArray removeAllObjects];
            
            for (SocialDataModel * dataModel in model.data ) {
                SocialFrameModel * frameModel = [[SocialFrameModel alloc]init];
                frameModel.dataModel = dataModel;
                [_dataArray addObject:frameModel];
            }
        }
        
        
        isMore ?[_tableView.mj_footer endRefreshing] :[_tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          isMore ?[_tableView.mj_footer endRefreshing] :[_tableView.mj_header endRefreshing];
    }];
}

- (void)createTableView {
    
  CGRect rect =   CGRectMake(0, CGRectGetMaxY(_segentedControl.frame), SCREENWIDTH, SCREENHEIGHT - 49 -CGRectGetHeight(_segentedControl.frame) -64 -10);
    _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource=  self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

}

- (void)createSegementCT {
    
    NSArray * array = @[@"精华",@"最新"];
    _segentedControl = [[UISegmentedControl alloc]initWithItems:array];
    _segentedControl.frame =CGRectMake((SCREEN_WIDTH - 200)/2.0, 10, 200, 30);
    _segentedControl.backgroundColor = [UIColor whiteColor];
    [_segentedControl addTarget:self action:@selector(leftOrRight:) forControlEvents:UIControlEventValueChanged];
    _segentedControl.tintColor = [UIColor orangeColor];
    _segentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:_segentedControl];
}

- (void)leftOrRight :(UISegmentedControl *)segentedController {
    if (segentedController.selectedSegmentIndex == 0) {
        _url = SCROIALESSENCE;
        [_dataArray removeAllObjects];
    }else if (segentedController.selectedSegmentIndex == 1) {
        [_dataArray removeAllObjects];
        _url = SCROIALNEWURL;
    }
//    [_tableView setContentOffset:CGPointMake(0,0) animated:NO];
      [_tableView reloadData];
    [_tableView.mj_header beginRefreshing];
  
}


#pragma mark --- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SocialTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell == nil) {
        cell = [[SocialTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArray.count > indexPath.row) {
        SocialFrameModel * model = _dataArray[indexPath.row];
        
        cell.frameModel = model;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostDetailViewController * pdVC = [[PostDetailViewController alloc]init];
    SocialFrameModel * model= _dataArray[indexPath.row];
    pdVC.dataModel = model.dataModel;
    [self.navigationController pushViewController:pdVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataArray.count < indexPath.row) {
        return 0;
    }
    if (_dataArray.count != 0) {
        SocialFrameModel * model = _dataArray[indexPath.row];
        return model.cellHeight +10;
    }
    return 10;
}

@end
