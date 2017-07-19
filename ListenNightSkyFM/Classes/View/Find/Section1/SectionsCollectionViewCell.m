//
//  SectionsCollectionViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/12.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "SectionsCollectionViewCell.h"
#import "ZyqTools.h"

@interface  SectionsCollectionViewCell () {
    UIImageView * _imageView;
    UILabel * _lable;

}

@end
@implementation SectionsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createAlloc];
    }
    return self;
}

- (void)createAlloc {
    _imageView = [UIImageView new];
    _lable = [UILabel new];
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_lable];
}

- (void)layoutSubviews {
    CGFloat width = self.contentView.frame.size.width/3;
    _imageView.frame = CGRectMake(0, 0, width, width);
    _imageView.center = self.contentView.center;
    _lable.frame = CGRectMake(CGRectGetMinX(_imageView.frame), CGRectGetMaxY(_imageView.frame), width, width);
    _lable.textAlignment = NSTextAlignmentCenter;
    _lable.font = ZYQFONT(13);
    
}

- (void)updateViewWith:(NSString *)title WithImageName:(NSString * )name{

    _imageView.image = [UIImage imageNamed:name];
    _lable.text = title;
}


@end
