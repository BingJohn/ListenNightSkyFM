//
//  PromotionTableViewCell.m
//  FMMusic
//
//  Created by 卢家浩 on 2017/7/16.
//  Copyright © 2017年 zyq. All rights reserved.
//

#import "PromotionTableViewCell.h"
#import "ZyqTools.h"
#import <UIImageView+WebCache.h>
#import "PromotionCollectionViewCell.h"
#import "ZyqLable.h"

@implementation PromotionTableViewCell {
    
    UICollectionView * _collectionView;
    ZyqLable * _lable;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _collectionView  = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:[self createLayout] ];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = TABLECOLOR;
        _lable = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 25) WithTitle:@"新晋主播" WithImageName:@"11"];
        [self.contentView addSubview:_collectionView];
        [self.contentView addSubview:_lable];
        
        
        [_collectionView registerClass:[PromotionCollectionViewCell class] forCellWithReuseIdentifier:@"Promotion"];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    _lable.frame = CGRectMake(0, 0,width, 25);
    _collectionView.frame = CGRectMake(0, CGRectGetMaxY(_lable.frame),width, height - CGRectGetMaxY(_lable.frame));
}

- (UICollectionViewFlowLayout *)createLayout {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat ySapce = 10;
    CGFloat width = ( SCREENWIDTH-3*ySapce) /4-10;
    
    //这个时候的cell 高度是44  出列cell的高度150值 还没给上 只能用数字表达
    layout.itemSize =CGSizeMake(width, width);
    
    
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 5);
    return layout;
}

-(void)setHotFMArray:(NSArray *)hotFMArray {

    _hotFMArray = hotFMArray;
    
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _hotFMArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PromotionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Promotion" forIndexPath:indexPath];
    
    cell.model = _hotFMArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.homePromotionDidSelectItemDelegate respondsToSelector:@selector(homePromotionDidSelectItemAtIndexPath:)]) {
        
        [self.homePromotionDidSelectItemDelegate homePromotionDidSelectItemAtIndexPath:indexPath];
    }
}

@end
