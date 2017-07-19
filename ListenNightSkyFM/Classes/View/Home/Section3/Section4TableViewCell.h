//
//  Section4TableViewCell.h
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeSection4DidSelectItemDelegate <NSObject>

-  (void)homeSection4DidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface Section4TableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) id<HomeSection4DidSelectItemDelegate> homeSection4DidSelectItemDelegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithTitle:(NSString *)title;
@end
