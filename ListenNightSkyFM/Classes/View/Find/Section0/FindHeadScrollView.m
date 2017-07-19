//
//  FindHeadScrollView.m
//  FMMusic
//
//  Created by zyq on 16/1/11.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "FindHeadScrollView.h"
#import <UIImageView+WebCache.h>
#import "HeadViewModel.h"

@interface FindHeadScrollView () <UIScrollViewDelegate>

@end
@implementation FindHeadScrollView

- (void)createPicWithTuiJianArray:(NSMutableArray *)TuiJianArray {
    self.dataArray = TuiJianArray;
    CGFloat width = self.frame.size.width;
    for (int i = 0; i <TuiJianArray.count; i++) {
        HeadDataModel * model = TuiJianArray [i];
        UIImageView * imageV= self.imageArray[i];
        imageV.frame = CGRectMake(0+width*i , 0, width, 200);
        imageV.userInteractionEnabled = YES;
        imageV.tag = i;
        //添加手势
        UITapGestureRecognizer  * tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureHandel:)];
        [imageV addGestureRecognizer:tgr];
        [imageV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    }
    // _scrollView 的设置
    self.scrollView.contentSize = CGSizeMake(width * TuiJianArray.count, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)customAlloc {
    self.imageView1 = [UIImageView new];
    self.imageView2 = [UIImageView new];
    self.imageView3 = [UIImageView new];
    [self.scrollView addSubview:self.imageView1];
    [self.scrollView addSubview:self.imageView2];
    [self.scrollView addSubview:self.imageView3];
    [self addSubview:self.scrollView];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width -50)/2.0, CGRectGetMaxY(self.scrollView.frame)-50, 50, 50)];
    [self addSubview:self.pageControl];
    self.imageArray = @[self.imageView1,self.imageView2,self.imageView3];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.numberOfPages = self.imageArray.count;
}

-(void)tapGestureHandel:(UITapGestureRecognizer *)tgr {
    //    NSInteger tag = tgr.view.tag;
    //    TuiJianModel * model = _dataArray[tag];
    
}
@end
