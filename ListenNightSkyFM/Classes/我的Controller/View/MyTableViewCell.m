//
//  MyTableViewCell.m
//  CommunityService
//
//  Created by lujh on 2017/6/6.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

#pragma mark -初始化frame

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MyTableViewCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
}

// 注意：cell是用initWithStyle初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setupSubViews];
        
    }
    
    return self;
    
}

#pragma mark -初始化frame
-(void)setupSubViews{
    
    // 右侧箭头
    UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -20 -12,12, 20, 20)];
    rightImage.image = [UIImage imageNamed:@"my_right_jump"];
    [self.contentView addSubview:rightImage];
    
    // icon
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20,12, 20, 20)];
    [self.contentView addSubview:self.iconImageView];
    
    
    // title
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.right +20, 12, SCREEN_WIDTH - self.iconImageView.right - 2*20, 20)];
    self.titleLabel.font =  Theme_Font_14;
    self.titleLabel.textColor = Theme_ContentColor_L;
    [self.contentView addSubview:self.titleLabel];
  
    
    // 版本
    self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(rightImage.left - 160, 12, 150, 20)];
    self.rightLabel.font =  Theme_Font_13;
    self.rightLabel.textColor = Theme_ContentColor_M;
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.hidden = YES;
    [self.contentView addSubview:self.rightLabel];
    
    // 缓存
    self.cacheLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImageView.right +80, 14, 80, 20)];
    self.cacheLabel.font =  Theme_Font_11;
    self.cacheLabel.textColor = Theme_ContentColor_M;
    self.cacheLabel.textAlignment = NSTextAlignmentRight;
    self.cacheLabel.hidden = YES;
    self.cacheLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.cacheLabel];

}

-(void)setImage:(NSString *)image {

    self.iconImageView.image = [UIImage imageNamed:image];
}

-(void)setTitle:(NSString *)title {

    _title = title;
    
    self.titleLabel.text = title;
    
    if ([title isEqualToString:@"关于聆听夜空FM"]) {
        self.rightLabel.hidden = NO;
        NSString *Version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        self.rightLabel.text =  [[NSString alloc]initWithFormat:@"版本%@",Version];
    }else {
    
        self.rightLabel.hidden = YES;
    }
    
    if ([title isEqualToString:@"清理缓存"]) {
        
        self.cacheLabel.hidden = NO;
        
    }else {
    
        self.cacheLabel.hidden = YES;
    }
}

- (void)setFloatSize:(CGFloat)floatSize {

    _floatSize = floatSize;
    
    self.cacheLabel.text = [NSString stringWithFormat:@"(%.1fMB)",floatSize];
    
    if (floatSize <= 0) {
        
        self.cacheLabel.hidden = YES;
        
    }else {
    
        if ([_title isEqualToString:@"清理缓存"]) {
            
            self.cacheLabel.hidden = NO;
            
        }
    }

}

@end
