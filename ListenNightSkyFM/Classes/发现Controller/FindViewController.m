//
//  FindViewController.m
//  FMMusic
//
//  Created by lujh on 17/4/3.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "FindViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "ZyqTools.h"
#import "HeadViewModel.h"
#import "FindHeadScrollView.h"
#import "FindSection0Cell.h"
#import "ZyqLable.h"
#import "FindSectionsCell.h"
#import "FindSection2TableViewCell.h"
#import "FindMoreAuthorModel.h"
#import "MusicPlayView.h"
#import "SearchViewController.h"
#import "MoreAuthorViewController.h"
#import "MoodDetailViewController.h"

@interface FindViewController () <UITableViewDataSource, UITableViewDelegate,FindHostSectionDidSelectItemDelegate,FindSectionDidSelectItemDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AFHTTPSessionManager * manager;
@property (nonatomic, strong) NSMutableArray * headDataArray;
@property (nonatomic, strong) NSMutableArray * authorArray;
@property (nonatomic, strong) NSMutableArray * imageNameArray;
@property (nonatomic, strong) NSArray * titleArray;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createArray];
    
    [self setNavigationBarTitle:@"发现"];
    
    [self creatTablView];
    [self creatMananger];
    [self downLoadHeadData];
    [self downLoadAuthorData];
}

- (void)createArray {
    _imageNameArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<9; i++) {
        NSString * str = [NSString stringWithFormat:@"emotion%d",i+1];
        [_imageNameArray addObject:str];
    }for (int j = 0; j < 9; j++) {
        NSString * str = [NSString stringWithFormat:@"scene%d",j+1];
        [_imageNameArray addObject:str];
    }
    _titleArray = @[@"烦躁",@"悲伤",@"孤独",@"弃疗",@"减压",@"无奈",@"快乐",@"感动",@"迷茫",@"睡前",@"旅行",@"散步",@"坐车",@"独处",@"失恋",@"失眠",@"随便",@"无聊"];
}


- (void)creatTablView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -64 -10) style:UITableViewStyleGrouped];
    _tableView .delegate = self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
}


- (void)creatMananger {
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

- (void)downLoadHeadData {
    
    [self.manager GET:FINDHEADURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HeadViewModel * headModel = [[HeadViewModel alloc]initWithData:responseObject error:nil];
        _headDataArray = headModel.data;
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)downLoadAuthorData {
    [self.manager GET:FINDAUTHORURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FindMoreAuthorModel * moreData = [[FindMoreAuthorModel alloc]initWithData:responseObject error:nil];
        _authorArray = moreData.data;
        NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndex:1];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        SearchViewController * shVc = [[SearchViewController alloc]init];
        [self.navigationController pushViewController:shVc animated:YES];
    }
}

//出列cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            
            FindSection0Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"id0"];
            if (cell == nil) {
                cell = [[FindSection0Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id0"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:{
            FindSectionsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
            if (cell ==nil) {
                cell = [[FindSectionsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
            }
            
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.findSectionDidSelectItemDelegate = self;
            cell.imageNameArray = self.imageNameArray;
            cell.titleArray = self.titleArray;
            
            return cell;
        
        }
            break;
        case 2: {
            FindSection2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id2"];
            if (cell == nil) {
                cell = [[FindSection2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id2"];
            }
            cell.dataArray  = _authorArray;
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.findHostSectionDidSelectItemDelegate = self;
            return cell;
        
        }
        default:
            break;
    }
    return nil;

}
//cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        default:
            break;
    }
    return 1;
    
}

//cell 高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 40;
            break;
        case 1:{
            CGFloat width = (2 * SCREENWIDTH -4*10)/6;
            return 3*width;
        }
            break;
        case 2:
            return 70 *_authorArray.count/2+25+50;
            break;
        default:
            break;
    }
    return 0;
    
}

//几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;

}
//头图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 210;
            break;
        case 1:
            return 0.01;
            break;
        default:
            break;
    }
    return 0.001;

}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

          CGRect rect = CGRectMake(0, 0, SCREENWIDTH, 200);
    if (section == 0) {
        FindHeadScrollView * findView = [[FindHeadScrollView alloc]initWithFrame:rect WithTuiJianArray:_headDataArray];
        return findView;
    }
    
    return nil;
}

#pragma mark -FindSectionDidSelectItemDelegate

- (void)findSectionDidSelectItemAtIndexPath:(NSIndexPath *)indexPath Ttile:(NSString *)title{

       NSString * urlStr = URLEncodedString(title);
       MoodDetailViewController * movc = [[MoodDetailViewController alloc]init];
        movc.url = urlStr;
        movc.titleNmae = title;
        [self.navigationController pushViewController:movc animated:YES];
}

#pragma mark -FindHostSectionDidSelectItemDelegate

- (void)findHostSectionDidSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    MoreAuthorViewController * mvc = [[MoreAuthorViewController alloc]init];
    DianTaiModel * model = _authorArray[indexPath.row];
    mvc.url  = model.id;
    mvc.dianTaiModel = model;
    [self.navigationController pushViewController:mvc animated:YES];
}

@end
