//
//  MusicTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/10.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>
#import "ZyqLable.h"
@interface MusicTableViewCell ()
@property (nonatomic, strong) UIImageView * coverImage;
@property (nonatomic, strong) UILabel     * contentLable;
@property (nonatomic, strong) UILabel     * favnumLable;
@property (nonatomic, strong) UILabel     * viewnumLable;
@property (nonatomic, strong) ZyqLable    * titleLable;

@end

@implementation MusicTableViewCell

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
    _coverImage = [UIImageView new];
    _contentLable = [UILabel new];
    _favnumLable = [UILabel new];
    _viewnumLable = [UILabel new];
    _titleLable = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, 100, 20) WithTitle:@"主播介绍" WithImageName:@"1"];
    [self.contentView addSubview:_titleLable];
    [self.contentView addSubview:_coverImage];
    [self.contentView addSubview:_contentLable];
    [self.contentView addSubview:_favnumLable];
    [self.contentView addSubview:_viewnumLable];
}

- (void)layoutSubviews {
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
    CGFloat width = SCREENWIDTH /5;
    _coverImage.frame = CGRectMake(xSpace, ySpace+ CGRectGetMaxY(_titleLable.frame), width, width);
    _coverImage.layer.cornerRadius = width/2;
    _coverImage.clipsToBounds = YES;
    
//
    CGFloat contenWidth =SCREENWIDTH-width-xSpace-100;
 CGFloat contenHeight =[self sizeWithText:_content maxSize:CGSizeMake(contenWidth, MAXFLOAT) font:ZYQFONT(10)].height;
    CGFloat  contenY = 2*ySpace;
    if (contenHeight > width +15) {
        contenHeight = width +15;
        
    }else{
        contenY =  _coverImage.center.y -contenHeight/2;
    }
    _contentLable.frame = CGRectMake(CGRectGetMaxX(_coverImage.frame)+xSpace,contenY, contenWidth, contenHeight);
    _contentLable.font = ZYQFONT(10);
    _contentLable.numberOfLines = 0;
    _contentLable.textColor = [UIColor lightGrayColor];
    
//
    _favnumLable.frame = CGRectMake(SCREENWIDTH -60, ySpace, 60, 30);
    _favnumLable.font = ZYQFONT(10);
    
    _viewnumLable.frame = CGRectMake(SCREENWIDTH-60, CGRectGetMaxY(_favnumLable.frame)+ySpace/2, 60, 30);
    _viewnumLable.font = ZYQFONT(10);
    
}

- (void)setContent:(NSString *)content {
    _content = content;
    _contentLable.text = _content;
    NSInteger listerCount = [_viewnum integerValue];
    if (listerCount >10000) {
        listerCount = listerCount/10000;
    }
    if (!(_favnum == nil)) {
        _favnumLable.text = [NSString stringWithFormat:@"喜欢:%@",_favnum];
    }else {
        _favnumLable.text = [NSString stringWithFormat:@"喜欢:0"];
        
    }
    
    _viewnumLable.text = [NSString stringWithFormat:@"收藏:%ldW",(long)listerCount];
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:_picUrl] placeholderImage:nil];
}

- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}


@end
