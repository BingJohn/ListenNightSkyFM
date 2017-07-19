//
//  ZyqCollectionViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "ZyqCollectionViewCell.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>
@interface ZyqCollectionViewCell ()  {

    UIImageView * _imageView;
    UILabel     * _label;

}

@end
@implementation ZyqCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        _label = [UILabel new];
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_label];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    _imageView.frame = CGRectMake(25, 0,height -20 , height -20);
    _label.frame = CGRectMake(17, CGRectGetMaxY(_imageView.frame)+10, width, 15);
    _label.font = [UIFont systemFontOfSize:15];
    _label.textAlignment = NSTextAlignmentLeft;
}

-(void)setModel:(CateGoryModel *)model {
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    _label.text = model.name;

}

@end
