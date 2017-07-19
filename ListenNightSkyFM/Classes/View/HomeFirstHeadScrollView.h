//
//  HomeFirstHeadScrollView.h
//  FMMusic
//
//  Created by lujh on 17/4/3.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeFirstHeadScrollView : UIView
@property (nonatomic, strong) UIImageView * imageView1;
@property (nonatomic, strong) UIImageView * imageView2;
@property (nonatomic, strong) UIImageView * imageView3;
@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong) NSTimer * timer;
- (instancetype)initWithFrame:(CGRect)frame WithTuiJianArray :(NSMutableArray *)TuijianArray;

@end
