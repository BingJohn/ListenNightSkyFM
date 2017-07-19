//
//  DownLoadViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/19.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "DownLoadViewController.h"
#import "HomeModel.h"
#import "WFDownLoad.h"
#import "DBManager.h"
#import "ZyqTools.h"
#import "DownLoadTableViewCell.h"
#import "ZyqLable.h"
#import "MusicPlayViewController.h"
#import "AppDelegate.h"
#import "AppDelegate+Common.h"

#define DIDLOAD @"didDownLoad"
@interface DownLoadViewController () <WFDownLoadDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) HotFmModel * model ;
//需要下载的url
@property (nonatomic, copy) NSString * playUrl;

@property (nonatomic, copy) DownLoadSuccessedBlock  downBlock;

@property (nonatomic, strong) WFDownLoad * downloadNet;

@property (nonatomic, strong) UITableView * tableView;
//正在下载的数组
@property (nonatomic, strong) NSMutableArray * downingArray;
//已经下完的数组
@property (nonatomic, strong) NSMutableArray * downedArray;

@end

@implementation DownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatDataSouce];
    [self creatTablView];
    [self createBarButton];
//    注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshUI) name:DIDLOAD object:nil];
}
- (void)createBarButton {
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonHandle:)];
    self.navigationItem.rightBarButtonItem = item;
    
}

//创建butotonitem
- (void)rightButtonHandle:(UIBarButtonItem *)item {
    if (_tableView.isEditing) {
        [_tableView setEditing:NO animated:YES];
        item.title = @"Edit";
        
    }else {
        [_tableView  setEditing:YES animated:YES];
        item.title = @"Done";
    }
    
}


- (void)refreshUI {
    [self creatDataSouce];
    [self.tableView reloadData];
}


-(void)dealloc {

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的下载";
}

- (void)creatDataSouce {
    [_downedArray removeAllObjects];
    [_downingArray removeAllObjects];
    _downingArray = [NSMutableArray arrayWithArray:[[DBManager sharedManager] readDowningModelsWithRecordType:MusicDownType]];
    _downedArray = [NSMutableArray arrayWithArray:[[DBManager sharedManager] readMusicModelsWithRecordType:MusicDownType]];
}

- (void)creatTablView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView .delegate = self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[DownLoadTableViewCell class] forCellReuseIdentifier:@"id"];
        
        [self.view addSubview:_tableView];
    }
}

#pragma mark -- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 30;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DownLoadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (indexPath.section == 0) {
        HotFmModel  * model = _downingArray[indexPath.row];
        cell.model = model;
    }else {
        HotFmModel  * model = _downedArray[indexPath.row];
        cell.model = model;
    }
        return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        ZyqLable * lable1 = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 25) WithTitle:@"正在下载" WithImageName:@"1"];
        return lable1;
    }
    if (section == 1) {
        {
            ZyqLable * lable = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 25) WithTitle:@"已下载" WithImageName:@"2"];
            return lable;
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _downingArray.count;
    }else {
        return _downedArray.count;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (id object in self.navigationController.childViewControllers) {
        if ([object isKindOfClass:[MusicPlayViewController class]]) {
            [object removeFromParentViewController];
        }
    }
    if (indexPath.section == 1) {
        MusicPlayViewController *mvplay = [MusicPlayViewController shareMusicMananger];
        HotFmModel * model = _downedArray[indexPath.row];
        mvplay.musicUrl = model.url;
        mvplay.musicList = _downedArray;
        mvplay.index = indexPath.row;
        mvplay.coverImageUrl = model.cover;
        mvplay.musicTitle = model.title;
        mvplay.isLocal = YES;
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate pushNextController:mvplay];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        if (_downingArray.count) {
            HotFmModel * model = _downingArray[indexPath.row];
            [_downingArray removeObjectAtIndex:indexPath.row];
             [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [[DBManager sharedManager]deleteLoadingModelForAppId:model.id recordType:MusicDownType];
        }
    }else {
    
        if (_downedArray.count) {
            HotFmModel * model = _downedArray[indexPath.row];
            [_downedArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [[DBManager sharedManager] deleteModelMusicForAppId:model.id recordType:MusicDownType];
            [self cleanWithPath:model.url];
            
        }
    }
}


- (void)cleanWithPath:(NSString *)path {
    
    NSArray * array = [path componentsSeparatedByString:@"/"];
    NSString * str  = array[array.count-1];
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 获取沙盒的目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = paths[0];
    
    // 下载文件存放的路径
    NSString *targetPath = [NSString stringWithFormat:@"%@/%@",document,@"com.iluckly.download"];
    
    NSString * cleanPath = [NSString stringWithFormat:@"%@/%@",targetPath,str];
    _downloadNet=[[WFDownLoad alloc]init];
//    [_downloadNet clean];
    [_downloadNet cleanWithPath:cleanPath];
}

#pragma mark ---- 下载方法
- (void)beginDownloadWith:(HotFmModel *)hotModel WithBlock:(DownLoadSuccessedBlock)downLoadBlocl {
    _model = hotModel ;
    _downBlock = downLoadBlocl;
    [self downUrlFromNet];
}



- (void)downUrlFromNet {
    
    BOOL isYes =   [[DBManager sharedManager] isExistAppFordowningAppId:_model.id recordType:MusicDownType];
    BOOL isLoad = [[DBManager sharedManager] isExistAppForMusicAppId:_model.id recordType:MusicDownType];
    if (isYes == YES && isLoad == YES) {
        
        return;
    }if (!isYes) {
        [[DBManager sharedManager] insertDowningModel:_model recordType:MusicDownType];
    }

        //    初始化
        _downloadNet = [[WFDownLoad alloc]initWithURL:_model.url startBlock:^(WFDownLoad *download) {
        } loadingBlock:^(WFDownLoad *download, double progressValue) {
            NSLog(@"***\n%f",progressValue);
        } finishBlock:^(WFDownLoad *download, NSString *filePath) {
            
            
            [[DBManager sharedManager] insertModel:_model recordType:MusicDownType WithPath:filePath];
            [[DBManager sharedManager] deleteLoadingModelForAppId:_model.id recordType:MusicDownType];
            //    发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:DIDLOAD object:nil];

            if (_downBlock) {
                _downBlock (YES);
            }
            
        } faildBlock:^(WFDownLoad *downLoad, NSError *faildError) {
            
        } overFile:YES];

    
    
    [_downloadNet start];
}


@end
