//
//  SectionOneTableViewCell.h
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeSectionOneDidSelectItemDelegate <NSObject>

-  (void)homeSectionOneDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SectionOneTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray * cateGorayArray;

@property (nonatomic, assign) id<HomeSectionOneDidSelectItemDelegate> homeSectionOneDidSelectItemDelegate;

@end
