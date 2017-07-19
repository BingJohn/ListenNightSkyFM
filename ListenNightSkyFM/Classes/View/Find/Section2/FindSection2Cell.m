//
//  FindSection2Cell.m
//  FMMusic
//
//  Created by zyq on 16/1/13.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "FindSection2Cell.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>
@interface FindSection2Cell ()
@property (nonatomic, strong) UIImageView * coverImageView;
@property (nonatomic, strong) UILabel     * nameLable;
@property (nonatomic, strong) UILabel     * favnumLable;

@end
@implementation FindSection2Cell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self ) {
        [self createAlloc];
    }
    return self;
}

- (void)createAlloc {
    _coverImageView = [UIImageView new];
    _nameLable = [UILabel new];
    _favnumLable = [UILabel new];
    
    [self.contentView addSubview:_coverImageView];
    [self.contentView addSubview:_nameLable];
    [self.contentView addSubview:_favnumLable];
}

- (void)layoutSubviews {

    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
//    touxiang
    _coverImageView.frame = CGRectMake(xSpace, ySpace, 50, 50);
    _coverImageView.layer.cornerRadius = 50/2;
    _coverImageView.clipsToBounds = YES;
    
//    name
    _nameLable.frame = CGRectMake(CGRectGetMaxX(_coverImageView.frame)+xSpace/2, ySpace +10, 100, 15);
    _nameLable.font = ZYQFONT(10);

//    喜欢
    _favnumLable.frame = CGRectMake(CGRectGetMaxX(_coverImageView.frame)+xSpace/2, CGRectGetMaxY(_nameLable.frame), 100, 20);
    _favnumLable.textColor = [UIColor lightGrayColor];
    _favnumLable.font = ZYQFONT(10);
    
}

-  (void)setModel:(DianTaiModel *)model {
    
    _model = model;
    
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    _favnumLable.text = [NSString stringWithFormat:@"喜欢:%@",model.favnum];
    _nameLable.text = model.title;

}

@end
