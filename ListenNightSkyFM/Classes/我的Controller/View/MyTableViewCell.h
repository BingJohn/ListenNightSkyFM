//
//  MyTableViewCell.h
//  CommunityService
//
//  Created by lujh on 2017/6/6.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
// icon
@property (nonatomic, strong) UIImageView *iconImageView;
// title
@property (nonatomic, strong) UILabel *titleLabel;
// 版本
@property (nonatomic, strong) UILabel *rightLabel;
// 缓存
@property (nonatomic, strong) UILabel *cacheLabel;
@property (nonatomic, assign) CGFloat floatSize;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;

+ (instancetype)cellWithTableView:(UITableView *)tableView ;

@end
