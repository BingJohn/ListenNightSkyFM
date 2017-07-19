

//
//  MeViewController.m
//  FMMusic
//
//  Created by lujh on 2017/7/14.
//  Copyright © 2017年 zyq. All rights reserved.
//

#import "MeViewController.h"
#import "ZyqTools.h"
#import "JWCache.h"
#import "CollectionViewController.h"
#import "AppDelegate.h"
#import "DownLoadViewController.h"
#import "MyTableViewCell.h"
#import "MyViewController.h"

@interface MeViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView * _tableView;
    UIImageView * _imageView;
    NSArray * _nameArray;
    NSArray * _sectionArray;
    NSArray * _imageArray;
    MBProgressHUD * _HUD;
    NSString * _strPath;
    CGFloat  floatSize;
}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"我的"];
    
    [self initVar];
    
    // 初始化头部ImageView
    [self setHeadImageView];
    
   
    [self creatTablView];
    
    _strPath = [JWCache cacheDirectory];
    
    floatSize = [self fileSizeAtPath:_strPath];
    
}

- (void)initVar {

    _HUD = [[MBProgressHUD alloc]init];
    
    _sectionArray = @[@[@"我的收藏"],
                      @[@"清理缓存"],
                      @[@"关于聆听夜空FM"],
                      @[@"客服电话"]];
    
    _imageArray = @[@[@"my_favorite"],
                    @[@"my_reccode"],
                    @[@"my_about"],
                    @[@"my_phone"]];
}

#pragma mark -初始化头部ImageView

- (void)setHeadImageView {

    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4);
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.image = [UIImage imageNamed:@"me_back"];
    [self.view addSubview:_imageView];
}

- (void)creatTablView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _imageView.bottom, SCREENWIDTH, SCREENHEIGHT)];
    _tableView .delegate = self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    
}

//读取缓存文件大小
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0;
    }
    return 0;
}

//清理缓存
+(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
   // [[SDImageCache sharedImageCache] cleanDisk];
}

#pragma mark -UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 10;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _sectionArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_sectionArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section == 0)||(indexPath.section ==1)||(indexPath.section ==2)) {
        
        MyTableViewCell *cell = [MyTableViewCell cellWithTableView:tableView];
        cell.title = _sectionArray[indexPath.section][indexPath.row];
        cell.image = _imageArray[indexPath.section][indexPath.row];
        cell.floatSize = floatSize;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else{
        
        static NSString *CellIdentifier = @"CELL";
        
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *phoneView = [[UIView alloc]initWithFrame:self.view.bounds];
        
        UIImageView *phoneImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_phone"]];
        phoneImage.frame = CGRectMake((SCREEN_WIDTH - 194)/2.0, 12, 20, 20);
        [phoneView addSubview:phoneImage];
        
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneImage.right + 10,0, 164, 44)];
        phoneLabel.backgroundColor = [UIColor clearColor];
        phoneLabel.font = Theme_Font_14;
        phoneLabel.textColor = RGB(245, 83, 80);
        phoneLabel.text = @"客服电话: 4000 888 000";
        [phoneView addSubview:phoneLabel];
        [cell.contentView addSubview:phoneView];
        return cell;
    }
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0: {
            
            CollectionViewController * collection = [[CollectionViewController alloc]init];
            [self.navigationController pushViewController:collection animated:YES];
        }
            
            break;
            
        case 1: {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"清理缓存" message:nil delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:@"清理", nil];
            [alertView show];
            
        }
            break;
            
        case 2: {
            
            MyViewController * setVC = [[MyViewController alloc]init];
            [self.navigationController pushViewController:setVC animated:YES];
            
        }
            break;
            
        case 3: {
            
            NSString *num = @"telprompt://4000-888-000";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
            
        }
            break;
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        [JWCache resetCache];
        floatSize = 0.0;
        [_tableView reloadData];
        
        _HUD.mode = MBProgressHUDModeCustomView;
        _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
        _HUD.labelText = @"清理成功";
        
        [self.view addSubview:_HUD];
        [_HUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            [_HUD removeFromSuperview];
        }];
        
    }
    
}
@end
