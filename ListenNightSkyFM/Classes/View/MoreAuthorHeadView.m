//
//  MoreAuthorHeadView.m
//  FMMusic
//
//  Created by zyq on 16/1/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MoreAuthorHeadView.h"
#import <UIImageView+WebCache.h>
#import "ZyqTools.h"
#import "DBManager.h"
@interface MoreAuthorHeadView () {
    UILabel * _listenCountLable;
    UILabel * _focusCountlable;
    UILabel * _contentLable;
    UIImageView * _bichImageView;

    UIButton * _collectionButton;
    UserModel * _userModel;
}
#define DIDCOLLECTION @"haveFollow"
@end
@implementation MoreAuthorHeadView


- (instancetype)initWithFrame:(CGRect)frame WithModel:(DianTaiModel *)dianTaiModel {

    self = [super initWithFrame:frame];
    if (self) {
        _model = dianTaiModel;
        [self customAlloc];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)customAlloc {
    _iconImageView = [UIImageView new];
    _nameLabel = [UILabel new];
    _listenCountLable = [UILabel new];
    _focusCountlable = [UILabel new];
    _contentLable = [UILabel new];
    _bichImageView = [UIImageView new];
    _collectionButton = [[UIButton alloc]init];
    [_collectionButton addTarget:self action:@selector(collectionOrDid:) forControlEvents:UIControlEventTouchUpInside];
    //
    [self addSubview:_iconImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_focusCountlable];
    [self addSubview:_listenCountLable];
    [self addSubview:_contentLable];
    [self addSubview:_bichImageView];
    [self addSubview:_collectionButton];
    
    [self updateViews];
}

- (void)collectionOrDid :(UIButton *)button {
    
    BOOL isCollection = [[DBManager sharedManager]isExistAppForAppId:_model.id recordType:AuthorType];
    if (isCollection) {
        [[DBManager sharedManager] deleteModelForAppId:_model.id recordType:AuthorType];
    }else {
        [[DBManager sharedManager]insertModel:_model recordType:AuthorType];
    }
    NSString * name = isCollection ? @"unFollow":DIDCOLLECTION;
    [_collectionButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    
    
}

-(void)layoutSubviews {

    [super layoutSubviews];

    _iconImageView.frame = CGRectMake(self.center.x-30, self.center.y-50, 60, 60);
    _iconImageView.layer.cornerRadius = 30;
    // 切完图后一定要clips  不然会出现黑边
    _iconImageView.clipsToBounds = YES;
    _nameLabel.frame = CGRectMake(CGRectGetMinX(_iconImageView.frame), CGRectGetMaxY(_iconImageView.frame), CGRectGetWidth(_iconImageView.frame), 13);
    _listenCountLable.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame)-15, CGRectGetMaxY(_nameLabel.frame), 50, 25);
    _focusCountlable.frame = CGRectMake(CGRectGetMaxX(_listenCountLable.frame)+10, CGRectGetMaxY(_nameLabel.frame), 50, 25);
    
    CGFloat height = [self sizeWithText:_model.content maxSize:CGSizeMake(100, MAXFLOAT) font:ZYQFONT(8)].height;
    if (height >= 50.f) {
        height = 50.f;
    }
    _contentLable.frame = CGRectMake(CGRectGetMinX(_listenCountLable.frame), CGRectGetMaxY(_listenCountLable.frame), 100, height);
    _bichImageView.frame = CGRectMake(CGRectGetMinX(_contentLable.frame)-20, CGRectGetMaxY(_listenCountLable.frame), 15, 15);
    //字体尺寸
//    namesize
    _nameLabel.font = ZYQFONT(15);
    _nameLabel.textAlignment =NSTextAlignmentCenter;
//    听众
    _listenCountLable.font = ZYQFONT(8);
//    评论
    _contentLable.font = ZYQFONT(8);
    _contentLable.numberOfLines = 0;
//    关注
    _focusCountlable.font = ZYQFONT(8);
    
    _collectionButton.frame = CGRectMake(SCREEN_WIDTH -100 -20, 15, 100, 52);
}
- (void)updateViews {
    
   _userModel = _model.user;
    [self updateImageView];
    
    
    NSInteger listerCount = [_model.viewnum integerValue];
    if (listerCount >10000) {
        listerCount = listerCount/10000;
    }
    _listenCountLable.text = [NSString stringWithFormat:@"收听 %ld万",listerCount];
    _focusCountlable.text = [NSString stringWithFormat:@"关注:%@",_model.favnum];
    _contentLable.text = _model.content;
    _bichImageView.image = [[UIImage imageNamed:@"shenfenPic"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    BOOL isCollection = [[DBManager sharedManager]isExistAppForAppId:_model.id recordType:AuthorType];
    
    NSString * title  = isCollection ?DIDCOLLECTION:@"unFollow";
    [_collectionButton setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
    

}
- (void)updateImageView {
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_userModel.avatar] placeholderImage:nil];
    _nameLabel.text = _model.title;
    
}

- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end
