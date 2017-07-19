//
//  FindSectionsCell.h
//  FMMusic
//
//  Created by zyq on 16/1/11.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FindSectionDidSelectItemDelegate <NSObject>

-  (void)findSectionDidSelectItemAtIndexPath:(NSIndexPath *)indexPath Ttile:(NSString*)title;

@end


@interface FindSectionsCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray * imageNameArray;
@property (nonatomic, strong) NSArray * titleArray;

@property (nonatomic, strong) NSMutableArray * array12;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) id<FindSectionDidSelectItemDelegate> findSectionDidSelectItemDelegate;
@end
