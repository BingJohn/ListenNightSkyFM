//
//  BaseViewController.m
//  StandardArchitecture
//
//  Created by lujh on 2017/7/11.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
    
    // 去掉下划线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 初始化导航栏
    [self setupNavigationBar];
    
}

#pragma mark -初始化导航栏

- (void)setupNavigationBar {
    
    //导航栏 返回 按钮
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (viewControllers.count > 1){
        
        [self.navigationItem setHidesBackButton:NO animated:NO];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 12, 21);
        [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        leftButton.adjustsImageWhenHighlighted = NO;
        [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
       
        
    }else{
        
        [self.navigationItem setHidesBackButton:YES animated:NO];
    }

}

#pragma mark -返回按钮点击事件

- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -设置导航栏标题

-(void)setNavigationBarTitle:(NSString *)title {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = titleLabel;
    
}

@end
