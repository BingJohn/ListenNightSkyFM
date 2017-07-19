//
//  MoreAuthorViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MoreAuthorViewController.h"
#import <UIImageView+WebCache.h>
#import "ZyqTools.h"
#import "MoreAuthorHeadView.h"
#import "ZyqButton.h"
#import <AFNetworking/AFNetworking.h>
#import "MoreModel.h"
#import "MoreTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "AppDelegate.h"
#import "MusicPlayViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "AppDelegate+Common.h"
#import "DBManager.h"
@interface MoreAuthorViewController () <UITableViewDataSource, UITableViewDelegate>{
    
    
    NSMutableArray * _dataArray;
    
    
}
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define Screenheight [[UIScreen mainScreen] bounds].size.height
#define kImageOriginHight 220


@end

@implementation MoreAuthorViewController

-(void)viewWillAppear:(BOOL)animated {
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    [self creatImage];
    [self creatTablView];
    [self createHeadView];
    [self createBackButton];
}



- (void)downLoadFromNetIsMore:(BOOL)isMore {
    NSInteger page = 0;
    if (isMore) {
        if (_dataArray.count%20 ==0) {
            page = _dataArray.count /20 *20;
        }else {
            [_tableView.mj_footer endRefreshing];
            return;
        }
        
    }
    AFHTTPSessionManager * mananger = [AFHTTPSessionManager manager];
    mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * urlStr = [NSString stringWithFormat:AuthorWorks,_url,(long)page];
    
    [mananger GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isMore) {
            MoreModel * moreModel = [[MoreModel alloc]initWithData:responseObject error:nil];
            for (HotFmModel * model  in moreModel.data) {
                [_dataArray addObject:model];
            }
        }else {
            [_dataArray removeAllObjects];
            MoreModel * moreModel = [[MoreModel alloc]initWithData:responseObject error:nil];
            for (HotFmModel * model  in moreModel.data) {
                [_dataArray addObject:model];
            }
        }
        
        [_tableView reloadData];
        isMore ?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        isMore ?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    }];
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
#define XIXFOURHEIGHT  0
- (void)creatImage {
    CGRect rect = CGRectMake(0, XIXFOURHEIGHT, SCREENWIDTH, 180);
    _imageView = [[UIImageView alloc]initWithFrame:rect];

    [_imageView sd_setImageWithURL:[NSURL URLWithString:_dianTaiModel.cover] placeholderImage:nil];
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    _effectView.frame = rect;
    _scale = _imageView.frame.size.width/_imageView.frame.size.height;
 [self.view addSubview:_imageView];
    [self.view addSubview:_effectView];
    
    
    self.headerImgHeight = 200 ;
    self.iconHeight = 60.f;
}

- (void)createHeadView {
    _headView = [[MoreAuthorHeadView alloc]initWithFrame:CGRectMake(0, 64, SCREENHEIGHT, 200) WithModel:_dianTaiModel];
    _tableView.tableHeaderView = _headView;
}
- (void)setDianTaiModel:(DianTaiModel *)dianTaiModel {
    _dianTaiModel = dianTaiModel;
}



- (void)creatTablView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, XIXFOURHEIGHT, SCREENWIDTH, SCREENHEIGHT-XIXFOURHEIGHT)];
    _tableView .delegate = self;
    _tableView.dataSource =self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self refresh];
    
}

- (void)refresh {
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downLoadFromNetIsMore:NO];
        
    }];
    _tableView.mj_header = header;
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self downLoadFromNetIsMore:YES];
    }];
    
    _tableView.mj_footer = footer;
    
    [_tableView.mj_header beginRefreshing];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    	
    MoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell ==nil) {
        cell = [[MoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.moreModel = _dataArray[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    HotFmModel * model = _dataArray[indexPath.row];
    MusicPlayViewController * mpVC = [MusicPlayViewController shareMusicMananger];;
//    需要遍历一下,把单例从导航push 队列中移除， 然后再push
    for (id object in self.navigationController.childViewControllers) {
        if ([object isKindOfClass:[MusicPlayViewController class]]) {
            [object removeFromParentViewController];
        }
    }

    mpVC.musicUrl = model.url;
    mpVC.musicList = _dataArray;
    mpVC.index = indexPath.row;
    mpVC.coverImageUrl = model.cover;
    mpVC.musicTitle = model.title;
    mpVC.isLocal = NO;
    DianTaiModel * model1 = model.diantai;
    if (model1 == nil) {
        mpVC.diantamodel = _dianTaiModel;
    }
    
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.subtype = @"fromBottom";
    animation.duration=  1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:mpVC animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 70;
}



#pragma mark - UIScrollViewDelgate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < 0) {
        CGRect f = _imageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset + kImageOriginHight;
        f.origin.x = -(f.size.height*ScreenWidth/kImageOriginHight -  ScreenWidth)/2;
        f.size.width = f.size.height*ScreenWidth/kImageOriginHight;
        _imageView.frame = f;
        _effectView.frame = _imageView.bounds;
    }else {
    
    self.imageView.frame = CGRectMake(0, 0, self.imageView.frame.size.width, 200 - scrollView.contentOffset.y);
    
    }
}@end
