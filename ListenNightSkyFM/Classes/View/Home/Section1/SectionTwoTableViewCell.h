//
//  SectionTwoTableViewCell.h
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"


@protocol HomeSectionTwoDidSelectItemDelegate <NSObject>

-  (void)homeSectionTwoDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SectionTwoTableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray * hotFMArray;

@property (nonatomic, assign) id<HomeSectionTwoDidSelectItemDelegate>homeSectionTwoDidSelectItemDelegate;
@end
