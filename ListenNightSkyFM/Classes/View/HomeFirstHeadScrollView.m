//
//  HomeFirstHeadScrollView.m
//  FMMusic
//
//  Created by lujh on 17/4/3.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "HomeFirstHeadScrollView.h"
#import <UIImageView+WebCache.h>
#import "HomeModel.h"

@interface HomeFirstHeadScrollView ()<UIScrollViewDelegate>

@end

@implementation HomeFirstHeadScrollView

- (instancetype)initWithFrame:(CGRect)frame WithTuiJianArray :(NSMutableArray *)TuijianArray {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        [self customAlloc];
        [self createPicWithTuiJianArray:TuijianArray];
        [self createTimer];
    }
    return self;
}


- (void)customAlloc {
    _imageView1 = [UIImageView new];
    _imageView2 = [UIImageView new];
    _imageView3 = [UIImageView new];
    [_scrollView addSubview:_imageView1];
    [_scrollView addSubview:_imageView2];
    [_scrollView addSubview:_imageView3];
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width -50)/2.0, CGRectGetMaxY(_scrollView.frame)-50, 50, 50)];
    [self addSubview:_pageControl];
    _imageArray = @[_imageView1,_imageView2,_imageView3];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.numberOfPages = _imageArray.count;
}

- (void)createPicWithTuiJianArray:(NSMutableArray *)TuiJianArray {
    _dataArray = TuiJianArray;
    CGFloat width = self.frame.size.width;
    for (int i = 0; i <TuiJianArray.count; i++) {
        TuiJianModel * model = TuiJianArray [i];
        UIImageView * imageV= _imageArray[i];
        imageV.frame = CGRectMake(0+width*i , 0, width, 200);
        imageV.userInteractionEnabled = YES;
        imageV.tag = i;
        //添加手势
        UITapGestureRecognizer  * tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureHandel:)];
        [imageV addGestureRecognizer:tgr];
        [imageV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    }
    // _scrollView 的设置
   _scrollView.contentSize = CGSizeMake(width * TuiJianArray.count, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;

}

- (void)createTimer {

    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage:) userInfo:nil repeats:YES];
        //定时器优先级比较高，同时处理多线程
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }

}

- (void)nextImage:(NSTimer *)timer {
    NSInteger page = 0;
    if (_pageControl.currentPage == _imageArray.count-1) {
        page = 0;
    }else {
        page  = _pageControl.currentPage + 1;
    }
        CGFloat offsetX = page * _scrollView.frame.size.width;
        CGPoint offset = CGPointMake(offsetX, 0);
    [_scrollView setContentOffset:offset animated:YES];
    
}


-(void)tapGestureHandel:(UITapGestureRecognizer *)tgr {
//    NSInteger tag = tgr.view.tag;
//    TuiJianModel * model = _dataArray[tag];
    
}
- (void) removeTimes {
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc {

    [self removeTimes];
}

@end
