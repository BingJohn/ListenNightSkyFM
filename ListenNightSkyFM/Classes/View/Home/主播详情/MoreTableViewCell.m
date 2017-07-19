//
//  MoreTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MoreTableViewCell.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>
@implementation MoreTableViewCell{
    UIImageView * _iconView;
    UILabel  * _titleLabel;
    UILabel * _nameLable;
    UILabel * _countLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createAlloc];
    }
    return self;
}


- (void)createAlloc {
    _iconView = [UIImageView new];
    _titleLabel = [UILabel new];
    _nameLable = [UILabel new];
    _countLabel = [UILabel new];
    
    
    [self.contentView addSubview:_iconView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_nameLable];
    [self.contentView addSubview:_countLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
    CGFloat width = self.contentView.frame.size.width;
    _iconView.frame = CGRectMake(xSpace, ySpace, 60, 60);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+xSpace, ySpace/2, width-CGRectGetMaxX(_iconView.frame), 25);
    _titleLabel.font =ZYQFONT(15);
    
    
    _nameLable.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+xSpace, CGRectGetMaxY(_titleLabel.frame), width, 20);
    _nameLable.font = ZYQFONT(10);
    _nameLable.textColor = [UIColor lightGrayColor];
    _countLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+xSpace, CGRectGetMaxY(_nameLable.frame), width, 20);
    _countLabel.font = ZYQFONT(10);
        _countLabel.textColor = [UIColor lightGrayColor];
}
- (void)setMoreModel:(HotFmModel *)moreModel {
    _moreModel =moreModel ;
    _titleLabel.text = moreModel.title;
    _nameLable.text = moreModel.speak;
    _countLabel.text = [NSString stringWithFormat:@"收听量 %@",moreModel.viewnum];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:moreModel.cover] placeholderImage:nil];
}
@end
