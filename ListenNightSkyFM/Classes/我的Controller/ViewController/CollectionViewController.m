//
//  CollectionViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/18.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "CollectionViewController.h"
#import "DBManager.h"
#import "ZyqTools.h"
#import "HomeModel.h"
#import "CollectionTableViewCell.h"
#import "ZyqTitleLable.h"
#import "MoreAuthorViewController.h"

@interface CollectionViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView * _tableView;
    NSMutableArray * _authorArray;
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"收藏"];
    
    [self gainDataSore];
    [self createBarButton];
    [self creatTablView];
}

- (void)createBarButton {
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 21);
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(backrightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
}

- (void)backrightBtnClick:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    if (_tableView.isEditing) {
        
       [_tableView setEditing:NO animated:YES];
       [btn setTitle:@"编辑" forState:UIControlStateNormal];
        
    }else {
        
        [_tableView  setEditing:YES animated:YES];
        
        [btn setTitle:@"取消" forState:UIControlStateSelected];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     DianTaiModel * model = _authorArray[indexPath.row];
    [_authorArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [[DBManager sharedManager]deleteModelForAppId:model.id recordType:AuthorType];
}

- (void)gainDataSore {
   _authorArray = (NSMutableArray *) [[DBManager sharedManager]readModelsWithRecordType:AuthorType];
}

- (void)creatTablView {
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _tableView .delegate = self;
    _tableView.dataSource =self;
    _tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell ==nil) {
        cell = [[CollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    DianTaiModel * model = _authorArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ;
    
    return _authorArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    DianTaiModel * model = _authorArray[indexPath.row];

    
    MoreAuthorViewController * maVC  = [[MoreAuthorViewController alloc]init];
    maVC.dianTaiModel = model;
    maVC.url = model.id;
    [self.navigationController pushViewController:maVC animated:YES];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return @"删除";
}

@end
