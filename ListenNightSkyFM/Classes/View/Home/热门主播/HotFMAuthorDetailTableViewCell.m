//
//  HotFMAuthorDetailTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/6.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "HotFMAuthorDetailTableViewCell.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>
@implementation HotFMAuthorDetailTableViewCell {
    UIImageView * _coverImageView;
    UILabel * _nameLable;
    UILabel * _contenLable;
    UILabel * _favoriteLable;
    UILabel * _lineLbale;


}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customAlloc];
    }

    return self;
}

- (void)customAlloc {
    _coverImageView = [UIImageView new];
    _nameLable = [UILabel new];
    _contenLable = [UILabel new];
    _favoriteLable = [UILabel new];
    _lineLbale = [UILabel new];
    [self.contentView addSubview:_coverImageView];
    [self.contentView addSubview:_nameLable];
    [self.contentView addSubview:_contenLable];
    [self.contentView addSubview:_favoriteLable];
    [self.contentView addSubview:_lineLbale];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
    CGFloat width = self.contentView.frame.size.width;
    CGFloat heght = self.contentView.frame.size.height;
//    头像
    _coverImageView.frame = CGRectMake(xSpace, ySpace, 50, 50);
    _coverImageView.layer.cornerRadius = 50/2;
    _coverImageView.clipsToBounds = YES;
    
//    名字
    CGFloat outX = CGRectGetMaxX(_coverImageView.frame)+xSpace;
    _nameLable.frame = CGRectMake(outX, ySpace, 100, 20);
    _nameLable.font = ZYQFONT(10);
//    简介
    CGFloat maxHeight = heght- CGRectGetMaxY(_nameLable.frame)-5;
    CGFloat contenHeight = [self sizeWithText:_model.content maxSize:CGSizeMake(width-outX-xSpace, MAXFLOAT) font:ZYQFONT(10)].height;
    if (contenHeight >maxHeight ) {
        contenHeight = maxHeight;
    }
    _contenLable.frame = CGRectMake(outX, CGRectGetMaxY(_nameLable.frame)+ySpace/2, width-outX-xSpace, contenHeight);
    _contenLable.font = ZYQFONT(10);
    _contenLable.numberOfLines = 0;
    _contenLable.textColor = [UIColor lightGrayColor];
    
//    粉丝
    _favoriteLable.frame = CGRectMake(width -70, ySpace, 50, 20);
    _favoriteLable.font = ZYQFONT(10);
    _favoriteLable.textColor = [UIColor lightGrayColor];
    _lineLbale.frame = CGRectMake(xSpace, heght, width-2*xSpace, 1);
    _lineLbale.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)setModel:(DianTaiModel *)model {
    _model = model;
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.cover] placeholderImage:nil];
    _nameLable.text = _model.title;
    _contenLable.text = _model.content;
    _favoriteLable.text =[NSString stringWithFormat:@"粉丝 %@",_model.favnum];

}

- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end
