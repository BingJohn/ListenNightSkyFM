//
//  MinorPostTableViewCell.h
//  FMMusic
//
//  Created by zyq on 16/1/16.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentTwoFrameModel.h"

typedef void(^FuckBlock)(BOOL wasFucking);
@interface MinorPostTableViewCell : UITableViewCell

@property (nonatomic, copy) ContentTwoFrameModel * dataFrame;
@property (nonatomic, strong) FuckBlock fuckBlock;
@end
