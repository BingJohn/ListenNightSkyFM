//
//  FindSection2TableViewCell.h
//  FMMusic
//
//  Created by zyq on 16/1/13.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FindHostSectionDidSelectItemDelegate <NSObject>

-  (void)findHostSectionDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FindSection2TableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) id<FindHostSectionDidSelectItemDelegate> findHostSectionDidSelectItemDelegate;
@end
