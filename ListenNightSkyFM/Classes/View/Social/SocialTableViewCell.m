//
//  SocialTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/15.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "SocialTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZyqTools.h"
@interface SocialTableViewCell ()
// 头像
@property (nonatomic, strong) UIImageView * avatarView;
//名字
@property (nonatomic, strong) UILabel * nickNameLable;
//评论个数
@property (nonatomic, strong) UILabel * commentnumLable;
//评论图片
@property (nonatomic, strong) UIImageView * commentnumView;

//时间
@property (nonatomic, strong) UILabel * timeLabel;
//标题
@property (nonatomic, strong) UILabel * titleLbael;
//内容
@property (nonatomic, strong) UILabel * contentLable;
//图片
@property (nonatomic, strong) UIImageView * picImageView;

@property (nonatomic, strong) UILabel * lineLable;


@end

@implementation SocialTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createAlloc];
    }
    return self;
}

- (void)createAlloc {
    _avatarView = [[UIImageView alloc]init];
    _nickNameLable = [UILabel new];
    _commentnumLable = [UILabel new];
    _commentnumView = [UIImageView new];
    _timeLabel = [UILabel new];
    _titleLbael = [UILabel new];
    _contentLable = [UILabel new];
    _picImageView = [UIImageView new];
    _lineLable = [UILabel new];
    //
    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_nickNameLable];
    [self.contentView addSubview:_commentnumLable];
    [self.contentView addSubview:_commentnumView];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_titleLbael];
    [self.contentView addSubview:_contentLable];
    [self.contentView addSubview:_picImageView];
    [self.contentView addSubview:_lineLable];

    
    
}

- (void)layoutSubviews {
//    _avatarFrame
//    _nickNameFrame
//    _timeFrame
//    _commentnumFrame
//    _commentnumViewFrame
//    _titleFrame
//    _contentFrame
//    _imageViewFrame
    [super layoutSubviews];
    
    
    _avatarView.frame = _frameModel.avatarFrame;
    _nickNameLable.frame = _frameModel.nickNameFrame;
    _timeLabel.frame = _frameModel.timeFrame;
    _commentnumLable.frame = _frameModel.commentnumFrame;
    _commentnumView.frame = _frameModel.commentnumViewFrame;
    _titleLbael.frame = _frameModel.titleFrame;
    _contentLable.frame = _frameModel.contentFrame;
    _picImageView.frame = _frameModel.imageViewFrame;
    _lineLable.frame = CGRectMake(10, self.contentView.frame.size.height -2, SCREENWIDTH - 10*2, 1);
    _lineLable.backgroundColor = [UIColor lightGrayColor];
}

- (void)setFrameModel:(SocialFrameModel *)frameModel {
    _frameModel = frameModel;
    SocialDataModel * dataModel = _frameModel.dataModel;
    UserModel * userModel = dataModel.user;
    
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:nil];
    
//    
    _nickNameLable.text = userModel.nickname;
    _nickNameLable.font = ZYQFONT(11);
    
    _commentnumLable.text = [NSString stringWithFormat:@"评论:%@", dataModel.commentnum] ;
    _commentnumLable.font =ZYQFONT(11);
    _timeLabel.text = dataModel.updated;
    _timeLabel.font = ZYQFONT(11);
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    
    _titleLbael.font = ZYQFONT(13);
    _titleLbael.textColor = TITLECOLOR;
    _titleLbael.text =  dataModel.title;
//    评论
    _contentLable.text = dataModel.content;
    _contentLable.font = ZYQFONT(13);
    _contentLable.numberOfLines = 0;
    if (dataModel.images.count!=0) {
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.images[0]] placeholderImage:nil];
    }

}



@end
