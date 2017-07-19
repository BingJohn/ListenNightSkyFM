//
//  MusicPlayTableView.m
//  FMMusic
//
//  Created by zyq on 16/1/10.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MusicPlayTableView.h"
#import "ZyqTools.h"
#import "MusicTableViewCell.h"
#import "MusicTableViewCell1.h"
#import <AFNetworking/AFNetworking.h>
#import "ContentModel.h"
#import "ContentFrame.h"
#import "MoreAuthorViewController.h"
#import "AppDelegate.h"
#import "ZyqLable.h"

@interface MusicPlayTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) AFHTTPSessionManager * manager;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * frameArray;

@end
@implementation MusicPlayTableView

+ (MusicPlayTableView *)shareMusicPlayTableViewWithFrame:(CGRect)frame WithStyle:(UITableViewStyle)style {

    static MusicPlayTableView * musicMananger = nil;
    @synchronized(self) {
        if (musicMananger == nil) {
            musicMananger = [[MusicPlayTableView alloc]initWithFrame:frame style:style];
        }
    }
    return musicMananger;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
     
        self.delegate = self;
        self.dataSource = self;
        _dataArray = [[NSMutableArray alloc]init];
        _frameArray = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor clearColor];
        [self createMananger];
    }
    return self;
}
#pragma mark --- tableViewDelegate

- (void)createMananger {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    [self downLodaFromNet];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return nil;
    }else {
        ZyqLable * label = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20) WithTitle:@"最新评论" WithImageName:@"2"];
        return label;
    
    }
  
}

//头视图 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.001f;
    }
    return 25;

}


//返回cell 高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SCREENWIDTH/5+20+20;
    }
    if (_frameArray.count && indexPath.section == 1) {
        ContentFrame * frameModel = _frameArray[indexPath.row];
        return frameModel.cellHeight;
    }
   return 20;
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (indexPath.row == 0 && _isKey && indexPath.section == 0) {
        MoreAuthorViewController * mvc = [[MoreAuthorViewController alloc]init];
        mvc.url = _authorKey;
        mvc.dianTaiModel = _diantaiModel;
        
        [appdelegate.nvc pushViewController:mvc animated:YES];
    }
}

//cell 个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return _dataArray.count;

 
}

//出列cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        MusicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id0"];
        if (cell == nil) {
        cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id0"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.backgroundColor = [UIColor clearColor];
        cell.picUrl = _picUrl;
        cell.favnum = _favnum;
        cell.viewnum = _viewnum;
        cell.content = _content;
        return cell;
    }
    
 
    MusicTableViewCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell1 == nil) {
        cell1 = [[MusicTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    if (_dataArray.count!= 0 &&_frameArray.count != 0 ) {
        cell1.dataModel = _dataArray[indexPath.row];
        cell1.viewFrame = _frameArray[indexPath.row];
    }
  cell1.backgroundColor = [UIColor clearColor];
   
    return cell1;
  
}

- (void)setFavnum:(NSString *)favnum {
    _favnum = favnum;
    [_dataArray removeAllObjects];
    [_frameArray removeAllObjects];
    [self createMananger];
}

//下载
- (void)downLodaFromNet {
    NSString * url = [NSString stringWithFormat:CONTENTURL,_contentUrl];
    [_manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ContentModel * contentModel = [[ContentModel alloc]initWithData:responseObject error:nil];
        for (ContentDataModel * model in contentModel.data) {
            ContentFrame * frameModel = [[ContentFrame alloc]init];
            frameModel.modelFrame = model;
            [_frameArray addObject:frameModel];
            [_dataArray addObject:model];
        }
        [self reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
