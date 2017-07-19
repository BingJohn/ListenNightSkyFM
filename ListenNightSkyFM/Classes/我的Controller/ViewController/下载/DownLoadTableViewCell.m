//
//  DownLoadTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/20.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "DownLoadTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZyqTools.h"
@interface DownLoadTableViewCell ()
@property (strong, nonatomic)  UIImageView *coverImage;
@property (strong, nonatomic)  UILabel *musicTitle;

@end
@implementation DownLoadTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _coverImage = [UIImageView new];
        _musicTitle = [UILabel new];
        [self.contentView addSubview:_coverImage];
        [self.contentView addSubview:_musicTitle];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
    _coverImage.frame = CGRectMake(xSpace, ySpace, 50, 50);
    _musicTitle.frame = CGRectMake(CGRectGetMaxX(_coverImage.frame)+xSpace, CGRectGetMaxY(_coverImage.frame)/2, SCREENWIDTH -CGRectGetMaxX(_coverImage.frame)-xSpace , 25);
}

- (void)setModel:(HotFmModel *)model {
    _model = model;
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    _musicTitle.text = model.title;

}

@end
