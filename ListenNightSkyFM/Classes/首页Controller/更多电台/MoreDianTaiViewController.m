//
//  MoreDianTaiViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MoreDianTaiViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "ZyqTools.h"
#import "MoreAuthor.h"
#import "HomeFirstHeadScrollView.h"
#import "PromotionTableViewCell.h"
#import "ZyqButton.h"
#import "ZyqLable.h"
#import "HotFMAuthorDetailTableViewCell.h"
#import "MoreAuthorViewController.h"
#import "AppDelegate.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MJRefresh/MJRefresh.h>
#import "MoreNewAuthorViewController.h"

@interface MoreDianTaiViewController () <UITableViewDataSource, UITableViewDelegate,HomePromotionDidSelectItemDelegate>{

    UITableView * _tableView;
    NSMutableArray  * _tuijianArray;
    NSMutableArray  * _newlistArray;
    NSMutableArray  * _hotlistArray;

}

@end

@implementation MoreDianTaiViewController

- (void)viewWillAppear:(BOOL)animated {
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.navigationController.navigationBarHidden = YES;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _hotlistArray = [NSMutableArray new];
    [self creatTablView];
    [self downLoadFromNet];
    [self createBackButton];
    
}
- (void)createBackButton {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 30, 27, 27);
    UIImage * image =[[UIImage imageNamed:@"more222"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(comeBack:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:button];
    
}

- (void)comeBack :(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatTablView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREENWIDTH, SCREENHEIGHT+20) style:UITableViewStyleGrouped];
    _tableView .delegate = self;
    _tableView.dataSource =self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = TABLECOLOR;
    [self.view addSubview:_tableView];
    [self creatRefresh];
    
}

- (void)creatRefresh {
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downLoadFromNet];
        
    }];
    _tableView.mj_header = header;

    [_tableView.mj_header beginRefreshing];
    
    
}

- (void)downLoadFromNet {
    
    AFHTTPSessionManager * mananger = [AFHTTPSessionManager manager];
    mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mananger GET:MoreAuthorUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MoreAuthor * authorModel = [[MoreAuthor alloc]initWithData:responseObject error:nil];
        MoreAuthorDataModel * model = authorModel.data;
        _tuijianArray = model.tuijian;
        _newlistArray = model.newlist;
        for (DianTaiModel * tuijianModel in model.hotlist) {
            [_hotlistArray addObject:tuijianModel];
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView.mj_header endRefreshing];
    }];
}

#pragma mark---- UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section ==0) {
        PromotionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PromotionTableViewCell"];
        if (cell == nil) {
            cell = [[PromotionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PromotionTableViewCell" ];
        }
        
        cell.hotFMArray = _newlistArray;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.homePromotionDidSelectItemDelegate = self;
        return cell;
        
     }else {
        
    HotFMAuthorDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell ==nil) {
        cell = [[HotFMAuthorDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
        cell.backgroundColor = [UIColor clearColor];
        cell.model = _hotlistArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DianTaiModel * model = _hotlistArray[indexPath.row];
    NSString * urlKey = model.id;
    MoreAuthorViewController * moreAuVC = [[MoreAuthorViewController alloc]init];
    moreAuVC.dianTaiModel = model;
    moreAuVC.url = urlKey;
    [self.navigationController pushViewController:moreAuVC animated:YES];

}

//每个区cell 的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    return _hotlistArray.count;
    
}

//cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat width = ( SCREENWIDTH-3*10) /4-10;
    if (indexPath.section == 0) {
        return width+50;
    }
    return 70;
}

//一共几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

// 头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 CGRect rect = CGRectMake(0, 0, SCREENWIDTH, 200);
    if (section == 0) {
        
        HomeFirstHeadScrollView * scroll = [[HomeFirstHeadScrollView alloc]initWithFrame:rect WithTuiJianArray:_tuijianArray];
        scroll.backgroundColor = [UIColor clearColor];
        return scroll;
    }else {
        ZyqLable * label = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 25) WithTitle:@"热门主播" WithImageName:@"1"];
        return label;
        
    }

}
// 头视图高度
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 200;
    }
    return 15;
}
//屁股视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
    
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
        btn.backgroundColor = TABLECOLOR;
        [btn setTitle:@"更多主播" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"my_right_jump"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:Theme_Font_20];
        [btn addTarget:self action:@selector(btnClik) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 9;
        [btn setImagePositionWithType:SSImagePositionTypeRight spacing:10];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(10, btn.top, SCREEN_WIDTH - 20, 1);
        lineView.backgroundColor = [UIColor lightGrayColor];
        [btn addSubview:lineView];
        
        return btn;
    }
    
    return nil;

}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }

    return 0.001f;
}

- (void)btnClik {

    MoreNewAuthorViewController * newVc = [[MoreNewAuthorViewController alloc]init];
    newVc.titleNmae  = @"更多主播";
    [self.navigationController pushViewController:newVc animated:YES];

}

#pragma mark -HomePromotionDidSelectItemDelegate

- (void)homePromotionDidSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    DianTaiModel * model = _newlistArray[indexPath.row];
    NSString * urlKey = model.id;
    MoreAuthorViewController * moreAuVC = [[MoreAuthorViewController alloc]init];
    moreAuVC.dianTaiModel = model;
    moreAuVC.url = urlKey;

    [self.navigationController pushViewController:moreAuVC animated:YES];
}

@end
