//
//  MoreAuthorHeadView.h
//  FMMusic
//
//  Created by zyq on 16/1/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface MoreAuthorHeadView : UIView

@property (nonatomic, strong)  UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong)    DianTaiModel * model;
- (instancetype)initWithFrame:(CGRect)frame WithModel:(DianTaiModel *)dianTaiModel;
@end
