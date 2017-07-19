//
//  PromotionTableViewCell.h
//  FMMusic
//
//  Created by 卢家浩 on 2017/7/16.
//  Copyright © 2017年 zyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomePromotionDidSelectItemDelegate <NSObject>

-  (void)homePromotionDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PromotionTableViewCell :  UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, copy) NSArray * hotFMArray;

@property (nonatomic, assign) id<HomePromotionDidSelectItemDelegate>homePromotionDidSelectItemDelegate;

@end
