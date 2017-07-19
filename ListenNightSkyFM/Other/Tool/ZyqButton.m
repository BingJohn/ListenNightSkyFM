//
//  ZyqButton.m
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "ZyqButton.h"
#import "MoreFmViewController.h"
#import "AppDelegate.h"
#import "MoreDianTaiViewController.h"
#import "MoreNewAuthorViewController.h"
#import "HomeViewController.h"
@interface ZyqButton () {

    UIImageView * _imageView;
}
@property (nonatomic, assign) ButtonType type;
@property (nonatomic, copy) NSString * title;

@property (nonatomic, strong) UILabel * lable;

@property (nonatomic, strong) UILabel * lineLable;

@end
@implementation ZyqButton



-(instancetype)initWithFrame:(CGRect)frame WithTitle :(NSString *)title WithType:(ButtonType)type {

    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        self.title = title;
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        self.showsTouchWhenHighlighted = YES;
        [self createAlloc];
        
    }
    return self;
}

- (void)createAlloc {
    
    _lable = [UILabel new];
    _imageView = [UIImageView new];
    _lineLable = [UILabel new];
    [self addSubview:_lable];
    [self addSubview:_imageView];
    [self addSubview:_lineLable];
    [self updateViews];
}

- (void)updateViews {
    CGFloat width = self.frame.size.width;
    _lineLable.frame = CGRectMake(10, 0, width-10*2, 1);
    _lineLable.backgroundColor = [UIColor lightGrayColor];
    _lable.frame = CGRectMake(120, 10, 90, 15);
    _imageView.frame = CGRectMake(CGRectGetMaxX(_lable.frame)-8, 4, 27, 27);
    _lable.text = _title;
    
    _lable.font = [UIFont systemFontOfSize:15];
    _imageView.image = [[UIImage imageNamed:@"more111"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



- (void)click:(UIButton *)button {
   
    HomeViewController *home = [[HomeViewController alloc] init];
    
    switch (self.type) {
        case Fmtype:
        {
        
            MoreFmViewController * fmVC = [[MoreFmViewController alloc]init];
            fmVC.url = @"0";
            fmVC.titleNmae  = @"最新fm";
            [home.navigationController pushViewController:fmVC animated:YES];
            
        }
            break;
        case LessonType:{
        
            MoreFmViewController * fmVC = [[MoreFmViewController alloc]init];
            fmVC.url = @"1";
            fmVC.titleNmae  = @"更多心理课";
            [home.navigationController pushViewController:fmVC animated:YES];
        }
            break;
        case DiantaiType: {
        
            MoreDianTaiViewController * mtVC = [[MoreDianTaiViewController alloc]init];
            [home.navigationController pushViewController:mtVC animated:YES];
        }
            break;
        case NewFMAuthor: {
            MoreNewAuthorViewController * newVc = [[MoreNewAuthorViewController alloc]init];
            [home.navigationController pushViewController:newVc animated:YES];
        
        }
            break;
        default:
            break;
    }
   

}
@end
