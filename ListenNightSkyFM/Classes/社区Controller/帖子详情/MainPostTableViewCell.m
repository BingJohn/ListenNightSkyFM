//
//  MainPostTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/16.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MainPostTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZyqTools.h"
@interface MainPostTableViewCell ()

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic)  UILabel *nickNameLable;
@property (strong, nonatomic)  UILabel *upDataLabel;
@property (strong, nonatomic)  UILabel *titleLable;
@property (strong, nonatomic)  UILabel *contentLable;

@property (strong, nonatomic) UIImageView * picImageView;

@end
@implementation MainPostTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createAlloc];
    }
    return self;
}

- (void)createAlloc {
    _nickNameLable = [UILabel  new];
    _avatarView = [UIImageView new];
    _upDataLabel = [UILabel new];
    _titleLable = [UILabel new];
    _contentLable = [UILabel new];
    _picImageView = [UIImageView new];
    
    [self.contentView addSubview:_picImageView];
    [self.contentView addSubview:_nickNameLable];
    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_upDataLabel];
    [self.contentView addSubview:_titleLable];
    [self.contentView addSubview:_contentLable];

}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    _avatarView.frame = _frameModel.avatarFrame;
    _nickNameLable.frame = _frameModel.nickNameFrame;
    
    _upDataLabel.frame = _frameModel.timeFrame;
    _titleLable.frame = _frameModel.titleFrame;
    _contentLable.frame = _frameModel.contentFrame;
    _picImageView.frame = _frameModel.imageViewFrame;
    
    
    
}

- (void)setFrameModel:(ContentFrameModel *)frameModel  {
    _frameModel = frameModel;
    SocialDataModel * dataModel = _frameModel.postModel;

    UserModel * userModel = dataModel.user;
    
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:nil];

    _nickNameLable.text = userModel.nickname;
    _nickNameLable.font = ZYQFONT(11);
    
    _upDataLabel.text = dataModel.updated;
    _upDataLabel.font = ZYQFONT(11);
    _upDataLabel.textColor = [UIColor lightGrayColor];
    
    _titleLable.font = ZYQFONT(13);
    _titleLable.textColor = TITLECOLOR;
    _titleLable.text =  dataModel.title;
    //    评论
    _contentLable.text = dataModel.content;
    _contentLable.font = ZYQFONT(12);
    _contentLable.numberOfLines = 0;
    if (dataModel.images.count != 0) {
        NSString * str =dataModel.images[0];
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    }
    
}

@end
