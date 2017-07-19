//
//  SectionOneTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "SectionOneTableViewCell.h"
#import "ZyqTools.h"
#import "ZyqCollectionViewCell.h"

@implementation SectionOneTableViewCell {
    
    UICollectionView * _collectionView;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:[self createLayout]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_collectionView];
        
       [_collectionView registerClass:[ZyqCollectionViewCell class] forCellWithReuseIdentifier:@"id"];
    }
    return self;
}

- (UICollectionViewFlowLayout *)createLayout {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat ySapce = 10;
    CGFloat width = (SCREENWIDTH -4*ySapce) /4;
    CGFloat height = (150 -3*ySapce)/2;
    
    layout.itemSize =CGSizeMake(width, height);
    
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    return layout;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.contentView.bounds;
    
}


- (void)setCateGorayArray:(NSArray *)cateGorayArray {
    
    _cateGorayArray = cateGorayArray;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.homeSectionOneDidSelectItemDelegate respondsToSelector:@selector(homeSectionOneDidSelectItemAtIndexPath:)]) {
        
        [self.homeSectionOneDidSelectItemDelegate homeSectionOneDidSelectItemAtIndexPath:indexPath];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _cateGorayArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZyqCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    
    cell.model = _cateGorayArray[indexPath.row];
    
    return cell;
}

@end
