//
//  HomeViewController.m
//  FMMusic
//
//  Created by lujh on 17/4/3.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "HomeViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "ZyqTools.h"
#import "HomeModel.h"
#import "HomeFirstHeadScrollView.h"
#import "SectionOneTableViewCell.h"
#import "SectionTwoTableViewCell.h"
#import "ZyqLable.h"
#import "Section2TableViewCell.h"
#import "Section4TableViewCell.h"
#import "ZyqButton.h"
#import "MusicPlayViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MJRefresh/MJRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "JWCache.h"
#import "MusicPlayView.h"
#import "NSString+Common.h"
#import "AppDelegate.h"
#import "ZyqTitleLable.h"
#import "MoreViewController.h"
#import "MoreAuthorViewController.h"
#import "MoreFmViewController.h"
#import "MoreDianTaiViewController.h"
#import "MoreNewAuthorViewController.h"
@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate,MBProgressHUDDelegate,HomeSectionOneDidSelectItemDelegate,HomeSectionTwoDidSelectItemDelegate,HomeSection4DidSelectItemDelegate>{

    UITableView * _tableView;
    NSMutableArray * _tuijianArray;
    NSMutableArray * _cateGoryArray;
    NSMutableArray * _hotFmArray;
    NSMutableArray * _newFmArray;
    NSMutableArray * _newLessonArray;
    NSMutableArray * _diantaiArray;
    NSMutableArray * _dataArray;
    MBProgressHUD * _hudProgress;
    
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"首页"];
    
    _dataArray = [[NSMutableArray alloc]init];
    [self creatTablView];
    _hudProgress = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_hudProgress];
    _hudProgress.mode = MBProgressHUDModeIndeterminate;
    
}

- (void)lefeSlip {
    
    CGRect rect = CGRectMake(0, 0, SCREENWIDTH, 20);
    UILabel * label = [[UILabel alloc]initWithFrame:rect ];
    label.textColor =[UIColor colorWithRed:0.969 green:0.961 blue:0.949 alpha:1.000];
    label.text =@"向下滑动有惊喜哦";
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 1;
    label.font = ZYQFONT(15);
    [self.view addSubview:label];
    [UIView animateWithDuration:3 animations:^{
        label.alpha = 0.1;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
    
    
    
    
}

//缓存处理

- (BOOL)smartCacheWiht:(NSString *)str {
    NSData * cacheData = [JWCache objectForKey:str];
    if (cacheData) {
        
        HomeModel * homeModel = [[HomeModel alloc]initWithData:cacheData error:nil];
        DataModel * dataModel = homeModel.data;
        _tuijianArray = dataModel.tuijian;
        _cateGoryArray = dataModel.category;
        _hotFmArray = dataModel.hotfm;
        _newFmArray = dataModel.newfm;
        _newLessonArray = dataModel.newlesson;
        _diantaiArray = dataModel.diantai;
        
        [_dataArray addObject:_cateGoryArray];
        [_dataArray addObject:_hotFmArray];
        [_dataArray addObject:_newFmArray];
        [_dataArray addObject:_newLessonArray];
        [_dataArray addObject:_diantaiArray];
        [_tableView.mj_header endRefreshing];
        [_tableView reloadData];
        _hudProgress.labelText = @"刷新缓存成功";
        [_hudProgress hide:YES];

        
    }else {
        [_tableView.mj_header endRefreshing];
        _hudProgress.labelText = @"网络开小差了";
        [_hudProgress hide:YES];
    }
    return YES;
}
- (void)downLoadisMore:(BOOL)isMore {
    static int page = 1;
    if (page != 1) {
        [_tableView.mj_header endRefreshing];
        return;
        
    }
    page++;
    _hudProgress.labelText = @"拼命载入中";
    [_hudProgress show:YES];
    AppDelegate * appdelegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (appdelegate.netState == noNet) {
      BOOL isExit =  [self smartCacheWiht:MD5Hash(SHOUYEURl)];
        if (isExit) {
            return;
        }
    }
    
    
    AFHTTPSessionManager * mananger = [AFHTTPSessionManager manager];
    mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mananger GET:SHOUYEURl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HomeModel * homeModel = [[HomeModel alloc]initWithData:responseObject error:nil];
        DataModel * dataModel = homeModel.data;
        _tuijianArray = dataModel.tuijian;
        _cateGoryArray = dataModel.category;
        _hotFmArray = dataModel.hotfm;
        _newFmArray = dataModel.newfm;
        _newLessonArray = dataModel.newlesson;
        _diantaiArray = dataModel.diantai;
        
        [_dataArray addObject:_cateGoryArray];
        [_dataArray addObject:_hotFmArray];
        [_dataArray addObject:_newFmArray];
        [_dataArray addObject:_newLessonArray];
        [_dataArray addObject:_diantaiArray];
         [_tableView.mj_header endRefreshing];
        [_tableView reloadData];
        _hudProgress.labelText = @"刷新成功";
        [_hudProgress hide:YES];
        [JWCache setObject:responseObject forKey:MD5Hash(SHOUYEURl)];
        
        [self lefeSlip];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView.mj_header endRefreshing];
        _hudProgress.labelText =@"网络开小差了";
        [_hudProgress hide:YES];
    }];
}

- (void)creatTablView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 -49) style:UITableViewStyleGrouped];
    _tableView .delegate = self;
    _tableView.dataSource =self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self creatRefresh];
    
}

- (void)creatRefresh {
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downLoadisMore:NO];
    }];
    _tableView.mj_header = header;
    [_tableView.mj_header beginRefreshing];
}

#pragma mark --  UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            SectionOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id0"];
            if (cell == nil) {
                cell = [[SectionOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id0"];
                }
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
                cell.cateGorayArray = _cateGoryArray;
            
            cell.homeSectionOneDidSelectItemDelegate = self;
            
            return cell;
        }
            break;
        case 1:{
            SectionTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id1"];
            if (cell == nil) {
                cell = [[SectionTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id1"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.hotFMArray = _hotFmArray;
            cell.homeSectionTwoDidSelectItemDelegate = self;
            return cell;
        }
            break;
        case 4: {
            Section4TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id4"];
            if (cell == nil) {
                cell = [[Section4TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id4"WithTitle:@"最新电台"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.dataArray = _diantaiArray;
            cell.homeSection4DidSelectItemDelegate = self;
            return cell;
            
        }
            break;
        case 2: {
            Section2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
            if (cell ==nil) {
                cell = [[Section2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.model = _newFmArray[indexPath.row];
            return cell;
        
        }
            break;
        case 3: {
            Section2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
            if (cell ==nil) {
                cell = [[Section2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.model = _newLessonArray[indexPath.row];
            return cell;
            
        }
            break;
        default:
            break;
    }
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id5"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id5"];
//    }
    
    return nil;
}

//每个section 中又几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        
            break;
        case 1:
            return 1;
            break;
        case 4:
            return 1;
            break;
        default:
            break;
    }
    return _newFmArray.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return _dataArray.count;
}

//每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
      CGFloat width = ( SCREENWIDTH-3*10) /4-10;
    switch (indexPath.section) {
        case 0:
            return 150;
            break;
        case 1:
            return 120;
            break;
        case 2:
            return 70;
            break;
        case 3:
            return 70;
            break;
        case 4:
            return width +50 ;
            break;
        default:
            break;
    }
    return 100;
}

//每一section的头视图
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat width = SCREENWIDTH;
    if (section == 0 ) {
       CGRect rect = CGRectMake(0, 0, SCREENWIDTH, 200);
        HomeFirstHeadScrollView * view = [[HomeFirstHeadScrollView alloc]initWithFrame:rect WithTuiJianArray:_tuijianArray];
        return view;
    }else if (section ==2) {
        
        ZyqLable * lable = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, width, 25) WithTitle:@"最新fm" WithImageName:@"1"];
        return lable;
    
    }else if (section ==3) {
        ZyqLable * lable = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, width, 25) WithTitle:@"最新心理课" WithImageName:@"2"];
        return lable;
    }
    return nil;
}

//每一section的头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 200.0f;
            break;
        case 2:
            return 20.f;
            break;
        case 3:
            return 15.f;
            break;
    }
    return 0.01f;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGRect rect = CGRectMake(0, 0, SCREENWIDTH, 50) ;
    switch (section) {
        case 0:
            return nil;
            break;
        case 1:
            return nil;
            break;
        case 2:
        {
            
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = rect;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:@"更多最新FM" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"my_right_jump"] forState:UIControlStateNormal];
            [btn.titleLabel setFont:Theme_Font_20];
            [btn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 7;
            [btn setImagePositionWithType:SSImagePositionTypeRight spacing:10];
            
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(10, btn.top -5, SCREEN_WIDTH - 20, 1);
            lineView.backgroundColor = [UIColor lightGrayColor];
            [btn addSubview:lineView];
            return btn;
        
        }
            break;
        case 3:
        {
            
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = rect;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:@"更多心理课" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"my_right_jump"] forState:UIControlStateNormal];
            [btn.titleLabel setFont:Theme_Font_20];
            [btn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImagePositionWithType:SSImagePositionTypeRight spacing:10];
            btn.tag = 8;
            
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(10, btn.top -5, SCREEN_WIDTH - 20, 1);
            lineView.backgroundColor = [UIColor lightGrayColor];
            [btn addSubview:lineView];
            
            return btn;
        }
            break;
        case 4:
        {
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = rect;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:@"更多电台" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"my_right_jump"] forState:UIControlStateNormal];
            [btn.titleLabel setFont:Theme_Font_20];
            [btn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 9;
            [btn setImagePositionWithType:SSImagePositionTypeRight spacing:10];
            
            UIView *lineView = [[UIView alloc] init];
            lineView.frame = CGRectMake(10, btn.top -5, SCREEN_WIDTH - 20, 1);
            lineView.backgroundColor = [UIColor lightGrayColor];
            [btn addSubview:lineView];
            return btn;
            
        }
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.01f;
            break;
            case 1:
            return 0.01f;
            break;
        case 4:
            return 40;
            break;
        default:
            break;
    }
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2 || indexPath.section ==3) {
        MusicPlayViewController * mvc = [MusicPlayViewController shareMusicMananger];
        HotFmModel * model =_dataArray[indexPath.section][indexPath.row];
//       set 方法调用的顺序 很重要  因为 （重写set方法中调用方法）
        CATransition *animation = [CATransition animation];
        //    rippleEffect
        animation.type = @"rippleEffect";
        animation.subtype = @"fromBottom";
        animation.duration=  1.0;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.navigationController.view.layer addAnimation:animation forKey:nil];
        mvc.musicUrl = model.url;
        mvc.coverImageUrl = model.cover;
        mvc.musicTitle = model.title;
        mvc.musicList = _dataArray[indexPath.section];
        mvc.index = indexPath.row;
        mvc.isLocal = NO;
        [self.navigationController pushViewController:mvc animated:YES];
        
    }

}

#pragma mark -HomeSectionOneDidSelectItemDelegate

- (void)homeSectionOneDidSelectItemAtIndexPath:(NSIndexPath *)indexPath {

        CateGoryModel * model = _cateGoryArray[indexPath.item];
    
        MoreViewController * mvc = [[MoreViewController alloc]init];
        mvc.url = model.id;
        mvc.titleNmae = model.name;
        [self.navigationController pushViewController:mvc animated:YES];
}

#pragma mark -HomeSectionTwoDidSelectItemDelegate

- (void)homeSectionTwoDidSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    HotFmModel * model = _hotFmArray[indexPath.row];
    MusicPlayViewController * mpVC = [MusicPlayViewController shareMusicMananger];
   
    mpVC.musicUrl = model.url;
    mpVC.coverImageUrl = model.cover;
    mpVC.musicTitle = model.title;
    mpVC.musicList = (NSMutableArray *)_hotFmArray;
    mpVC.index = indexPath.row;
    mpVC.isLocal = NO;

    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.subtype = @"fromBottom";
    animation.duration=  1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:mpVC animated:YES];
}

#pragma mark -HomeSection4DidSelectItemDelegate

- (void)homeSection4DidSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    DianTaiModel * model = _diantaiArray[indexPath.row];
    NSString * urlKey = model.id;
    MoreAuthorViewController * moreAuVC = [[MoreAuthorViewController alloc]init];
    moreAuVC.dianTaiModel = model;
    moreAuVC.url = urlKey;
    
    [self.navigationController pushViewController:moreAuVC animated:YES];
}

- (void)btnClik:(UIButton*)btn {

    NSUInteger tag = btn.tag;
    
    switch (tag) {
        case 7:
        {
            
            MoreFmViewController * fmVC = [[MoreFmViewController alloc]init];
            fmVC.url = @"0";
            fmVC.titleNmae  = @"最新fm";
            [self.navigationController pushViewController:fmVC animated:YES];
            
        }
            break;
        case 8:{
            
            MoreFmViewController * fmVC = [[MoreFmViewController alloc]init];
            fmVC.url = @"1";
            fmVC.titleNmae  = @"更多心理课";
            [self.navigationController pushViewController:fmVC animated:YES];
        }
            break;
        case 9: {
            
            MoreDianTaiViewController * mtVC = [[MoreDianTaiViewController alloc]init];
            [self.navigationController pushViewController:mtVC animated:YES];
        }
            break;
        
        default:
            break;
    }
}

@end
