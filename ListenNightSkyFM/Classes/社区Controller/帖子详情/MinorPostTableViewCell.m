//
//  MinorPostTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/16.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MinorPostTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZyqTools.h"

@interface MinorPostTableViewCell ()
@property (strong, nonatomic)  UIImageView *avatarView;
@property (strong, nonatomic)  UILabel *floorCount;
@property (strong, nonatomic)  UILabel *nickName;
@property (strong, nonatomic)  UILabel *content;

@property (strong, nonatomic)  UILabel *timeLable;

@property (strong, nonatomic) UIButton * fuckButton;


@end
@implementation MinorPostTableViewCell

- (void)awakeFromNib {
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createAlloc];
    }
    return self;

}

- (void)createAlloc {
    _avatarView = [UIImageView new];
    _floorCount = [UILabel new];
    _content = [UILabel new];
    _timeLable = [UILabel new];
    _fuckButton = [UIButton new];
    
    [self.contentView addSubview:_fuckButton];
    [self.contentView addSubview:_avatarView];
    [self.contentView addSubview:_floorCount];
    [self.contentView addSubview:_content];
    [self.contentView addSubview:_timeLable];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _avatarView.frame = _dataFrame.avatarViewFrame;
    _floorCount.frame = _dataFrame.floorCountFrame;
    _floorCount.font = ZYQFONT(13);
    _floorCount.textColor = [UIColor lightGrayColor];
    
    
    _content.frame = _dataFrame.contentFrame;
    _content.numberOfLines = 0;
    _content.font = ZYQFONT(14);
    _timeLable.frame = _dataFrame.timeLableFrame;
    _timeLable.font = ZYQFONT(13);
    _timeLable.textColor = [UIColor lightGrayColor];
    _fuckButton.frame = CGRectMake(SCREENWIDTH - 50, CGRectGetMinY(_timeLable.frame), 40, 20);
    [_fuckButton addTarget:self action:@selector(fuckClick:) forControlEvents:UIControlEventTouchUpInside];
    [_fuckButton setTitle:@"举报" forState:UIControlStateNormal];
    [_fuckButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _fuckButton.titleLabel.font = ZYQFONT(13);

}

- (void)fuckClick:(UIButton *)button {
    if (_fuckBlock) {
        _fuckBlock(YES);
    }
    
}

- (void)setDataFrame:(ContentTwoFrameModel *)dataFrame {
    _dataFrame = dataFrame;
    SocialDataModel * dataModel = _dataFrame.dataModel;
    UserModel * model = dataModel.user;
    
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];
    _floorCount.text = [NSString stringWithFormat:@"%@楼  %@",dataModel.floor,model.nickname];
    _content.text = dataModel.content;
    _timeLable.text = dataModel.created;
    
    
}
@end
