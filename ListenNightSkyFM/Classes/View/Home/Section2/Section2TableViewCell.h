//
//  Section2TableViewCell.h
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "MoreModel.h"
@interface Section2TableViewCell : UITableViewCell

@property (nonatomic, strong) HotFmModel * model;

@property (nonatomic, strong) HotFmModel * moreModel;
@end
