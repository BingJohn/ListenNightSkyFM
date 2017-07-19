//
//  MusicTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/10.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MusicTableViewCell1.h"
#import "NSDate+CH.h"
#import <UIImageView+WebCache.h>
#import "ZyqTools.h"
@interface MusicTableViewCell1 ()
@property (nonatomic, strong) UILabel * nickName;
@property (nonatomic, strong) UIImageView * avatar;
@property (nonatomic, strong) UILabel * content;
@property (nonatomic, strong) UILabel * created;
@end

@implementation MusicTableViewCell1

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createAlloc];
    }
    return self;
}

- (void)createAlloc {
    _nickName = [UILabel new];
    _avatar = [UIImageView new];
    _content = [UILabel new];
    _created = [UILabel new];
    
    
    [self.contentView addSubview:_nickName];
    [self.contentView addSubview:_avatar];
    [self.contentView addSubview:_content];
    [self.contentView addSubview:_created];
    
}

- (void)setDataModel:(ContentDataModel *)dataModel {
    _dataModel = dataModel;
    UserModel * model = _dataModel.user;
    
    //  名字
    _nickName.text = model.nickname;
    _nickName.font = ZYQFONT(11);
    _nickName.textColor = [UIColor blackColor];
    
    //    头像
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];
   
    //    评论
    _content.text = _dataModel.content;
    _content.font = ZYQFONT(13);
    _content.textColor = [UIColor blackColor];
    _content.numberOfLines = 0;
    
    //    时间
    _created.text = [self ptimeWith:_dataModel.created_str];
    _created.font = ZYQFONT(11);
    _created.textColor = [UIColor lightGrayColor];
    
    
    
}


- (void)setViewFrame:(ContentFrame *)viewFrame {
     _viewFrame = viewFrame;
    _avatar.frame = _viewFrame.avatarFrame;
    _avatar.layer.cornerRadius = CGRectGetWidth(_avatar.frame)/2;
    _avatar.clipsToBounds = YES;
    _nickName.frame = _viewFrame.nickNameFrame;
    _content.frame = _viewFrame.contentFrame;
    _created.frame = _viewFrame.createdFrame;
}




//判断时间
-(NSString *)ptimeWith:(NSString *)ptime
{
    
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    fmt.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *creatDate=[fmt dateFromString:ptime];
    
    
    //判断是否为今年
    if (creatDate.isThisYear) {//今年
        if (creatDate.isToday) {
            //获得微博发布的时间与当前时间的差距
            NSDateComponents *cmps=[creatDate deltaWithNow];
            if (cmps.hour>=1) {//至少是一个小时之前发布的
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            }else if(cmps.minute>=1){//1~59分钟之前发布的
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            }else{//1分钟内发布的
                return @"刚刚";
            }
        }else if(creatDate.isYesterday){//昨天发的
            fmt.dateFormat=@"昨天 HH:mm";
            return [fmt stringFromDate:creatDate];
        }else{//至少是前天发布的
            fmt.dateFormat=@"yyyy-MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
        }
    }else           //  往年
    {
        fmt.dateFormat=@"yyyy-MM-dd";
        return [fmt stringFromDate:creatDate];
    }
    
}



@end
