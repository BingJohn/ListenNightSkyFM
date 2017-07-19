//
//  Section4CollectionViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "Section4CollectionViewCell.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>

@implementation Section4CollectionViewCell{
    
    UIImageView *_imageView;
    UILabel * _lable;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        _lable = [UILabel new];
        
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_lable];
    }
    
    return self;
}
- (void)layoutSubviews {
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    CGFloat space = 30;
    _imageView.frame = CGRectMake(0, 0, width, height);
    _lable.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame), width, space-10);
    _imageView.layer.cornerRadius = width/2;
    _imageView.clipsToBounds = YES;
    _lable.font = ZYQFONT(10);
    _lable.textAlignment = NSTextAlignmentCenter;
    _lable.numberOfLines = 0;
    
    
}
//手势实现
-(void)tapGestureHandel:(UITapGestureRecognizer *)tgr {
    
    
}

- (void)setModel:(DianTaiModel *)model {
    
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    _lable.text = model.title;
    NSLog(@"-------%@",model.title);
}

@end
