//
//  Section2TableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "Section2TableViewCell.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>
@implementation Section2TableViewCell {
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
    _iconView.frame = CGRectMake(xSpace, ySpace, 50, 50);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+xSpace, ySpace, width-CGRectGetMaxX(_iconView.frame), 25);
    _titleLabel.font =ZYQFONT(15);
    
    
    _nameLable.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+xSpace, CGRectGetMaxY(_titleLabel.frame)+ySpace/2, width, 25);
    _nameLable.font = ZYQFONT(10);
    _nameLable.textColor = [UIColor lightGrayColor];
    _countLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+xSpace, CGRectGetMaxY(_nameLable.frame)+ySpace/2, width, 25);
    _countLabel.font = ZYQFONT(10);

}

- (void)setModel:(HotFmModel *)model {
    _model = model;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    _nameLable.text = model.speak;
    _titleLabel.text = model.title;


}

- (void)setMoreModel:(HotFmModel *)moreModel {
    _moreModel =moreModel ;
    _titleLabel.text = moreModel.title;
    _nameLable.text = moreModel.speak;
    _countLabel.text = [NSString stringWithFormat:@"收听量 %@",moreModel.viewnum];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:moreModel.cover] placeholderImage:nil];

}


@end
