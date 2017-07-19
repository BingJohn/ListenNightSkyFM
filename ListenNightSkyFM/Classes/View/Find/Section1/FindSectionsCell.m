//
//  FindSectionsCell.m
//  FMMusic
//
//  Created by zyq on 16/1/11.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "FindSectionsCell.h"
#import "ZyqTools.h"
#import "SectionsCollectionViewCell.h"

#define HEIGHT (2 * SCREENWIDTH -4*10)/6-10;
@interface FindSectionsCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollerView;

@property (nonatomic, strong) UICollectionView * collectionView;

@end
@implementation FindSectionsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createView];
    
    }

    return self;
}
-(void)setTitleArray:(NSArray *)titleArray {

    _titleArray = titleArray;
}

-(void)setImageNameArray:(NSMutableArray *)imageNameArray {

    _imageNameArray =imageNameArray;
}

- (void)createView {
    
    CGFloat width = (2 * SCREENWIDTH -4*10)/6-10;
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 3*(width+10))];
    _scrollerView.pagingEnabled = YES;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 2*SCREENWIDTH, 3*(width+10)) collectionViewLayout:[self collectionFlowLayoute]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _scrollerView.contentSize = CGSizeMake(2*SCREENWIDTH, 0);
    [self.contentView addSubview:_scrollerView];
    [_scrollerView addSubview:_collectionView];
    [_collectionView reloadData];
    
    [_collectionView registerClass:[SectionsCollectionViewCell class] forCellWithReuseIdentifier:@"id"];
    
}

- (UICollectionViewFlowLayout *)collectionFlowLayoute {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat xSpace = 10;
    CGFloat width = (2 * SCREENWIDTH -4*xSpace)/6-10;
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 0, 5);
    layout.itemSize =  CGSizeMake(width, width);
    
    return layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return _imageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SectionsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    [cell updateViewWith:_titleArray[indexPath.row] WithImageName:  _imageNameArray[indexPath.row]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView   didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
      NSString * str = _titleArray[indexPath.row];

    if ([self.findSectionDidSelectItemDelegate  respondsToSelector:@selector(findSectionDidSelectItemAtIndexPath: Ttile:)]) {
        
        [self.findSectionDidSelectItemDelegate findSectionDidSelectItemAtIndexPath:indexPath Ttile:str];
    }
  
}

@end
