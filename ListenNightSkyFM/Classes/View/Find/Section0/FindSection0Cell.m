//
//  FindSection0Cell.m
//  FMMusic
//
//  Created by zyq on 16/1/11.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "FindSection0Cell.h"
#import "ZyqTools.h"

@interface FindSection0Cell ()
@property (nonatomic, strong) UILabel * lable;
@property (nonatomic, strong) UIImageView * searchImage;

@end
@implementation FindSection0Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createAlloc];
    }
    return self;
}

- (void)createAlloc {
    _lable = [UILabel new];
    _searchImage = [UIImageView new];
    
    
    [self.contentView addSubview:_lable];
    [self.contentView addSubview:_searchImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
    _lable.frame = CGRectMake(xSpace, ySpace, SCREENWIDTH, 20);
    _searchImage.frame = CGRectMake(SCREENWIDTH -20, ySpace, 20, 20);
    
    _searchImage.image = [[UIImage imageNamed:@"iconfont-shouyezhuyetubiao05-2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _lable.text = @"搜索主播/节目";
    _lable.font = ZYQFONT(13);
    _lable.textColor  = [UIColor lightGrayColor];
    
}



@end
