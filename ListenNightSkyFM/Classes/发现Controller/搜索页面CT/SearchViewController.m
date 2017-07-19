//
//  SearchViewController.m
//  FMMusic
//
//  Created by zyq on 16/1/14.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "SearchViewController.h"
#import "ZyqTools.h"
#import "NSString+Common.h"
#import <AFNetworking/AFNetworking.h>
#import "SearchTagView.h"
#import "HeadViewModel.h"
#import "AppDelegate.h"
#import "HotSearchViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>

@interface SearchViewController () <UISearchBarDelegate> {
    UISearchBar * _searchBar;
    NSString * _searchWorld;
    NSInteger _page;
    AFHTTPSessionManager * _mananger;
    UILabel * _label;
    SearchTagView * _tagView;
    NSMutableArray * _viewTagArray;
    
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"搜索"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSearchBar];

    [self createMananger];
    [self createTGR];
    
}

- (void)createTGR {
    UISwipeGestureRecognizer * wgr = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(popLastVC:)];
    wgr.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:wgr];
}

- (void)popLastVC :(UISwipeGestureRecognizer *)wgr{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)createView {

   _tagView = [[SearchTagView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_label.frame)+10, SCREENWIDTH, 100)];
    _tagView.dataArray = _viewTagArray;
    [self.view addSubview:_tagView];
    
}
- (void)createMananger {
    _mananger = [AFHTTPSessionManager manager];
    _mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self downLoadFromNet];
}

- (void)createLabel {
    _label = [UILabel new];
    _label.text = @"热门搜索";
    _label.frame = CGRectMake(10, CGRectGetMaxY(_searchBar.frame)+20, SCREENWIDTH, 20);
    _label.font = ZYQFONT(13);
    _label.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:_label];
}

- (void)downLoadFromNet {
    [_mananger GET:HOTSEARCH parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HeadViewModel * model = [[HeadViewModel alloc]initWithData:responseObject error:nil];
        _viewTagArray = model.data;
        
        [self createLabel];
        [self createView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)createSearchBar {
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH , 44)];
    _searchBar.placeholder = @"搜索喜欢的主播或fm";
    _searchBar.delegate = self;
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.backgroundImage = [UIImage imageNamed:@"navigationBar"];
    _searchBar.tintColor = [UIColor whiteColor];
    [self.view addSubview:_searchBar];
}

#pragma mark ---- searchBar 的代理

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {

    [searchBar setShowsCancelButton:YES animated:YES];
    for (UIView * view in [searchBar.subviews[0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    return YES;
}

//点击确定按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    _searchWorld =  URLEncodedString(searchBar.text);
   
    if (![_searchWorld isEqualToString:@""]) {
        
        
        HotSearchViewController * hotSVC = [[HotSearchViewController alloc]init];
        hotSVC.url = _searchWorld;
        hotSVC.titleNmae = searchBar.text;
        [self.navigationController pushViewController:hotSVC animated:YES];
    }
    if (_label) {
        [self.view addSubview:_label];
    }
    if (_tagView) {
        [self.view addSubview:_tagView];
    }
    searchBar.text = @"";
   

}

//搜索内容改变时
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (_label) {
        [_label removeFromSuperview];
    }
    if (_tagView) {
        [_tagView removeFromSuperview];
    }
    if ([searchBar.text isEqualToString:@""]) {
        if (_label) {
            [self.view addSubview:_label];
        }
        if (_tagView) {
            [self.view addSubview:_tagView];
        }
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    [self.navigationController popViewControllerAnimated:YES];
}


@end
