//
//  CollectionTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/18.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZyqTools.h"
@implementation CollectionTableViewCell {
    UIImageView * _coverImageView;
    UILabel * _titleLable;
    
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _coverImageView = [UIImageView new];
        [self.contentView addSubview:_coverImageView];
        _titleLable = [UILabel new];
        [self.contentView addSubview:_titleLable];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _coverImageView.frame = CGRectMake(10, 10, 50, 50);
    _coverImageView.layer.cornerRadius = 25;
    _coverImageView.clipsToBounds = YES;
    
    _titleLable .frame = CGRectMake(CGRectGetMaxX(_coverImageView.frame)+20, 20, SCREENWIDTH - CGRectGetMaxX(_coverImageView.frame), 20);
    _titleLable.font = ZYQFONT(13);
    
}



- (void)setModel:(DianTaiModel *)model {
    UserModel * userModel = model.user;
    _titleLable.text = userModel.nickname;
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:nil];

}
@end
