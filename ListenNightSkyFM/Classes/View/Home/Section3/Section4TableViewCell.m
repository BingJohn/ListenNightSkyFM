//
//  Section4TableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "Section4TableViewCell.h"
#import "ZyqLable.h"
#import "ZyqTools.h"
#import "Section4CollectionViewCell.h"

@implementation Section4TableViewCell {
    ZyqLable * _lable;
    UICollectionView * _collectionView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithTitle:(NSString *)title {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _collectionView  = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:[self createLayout] ];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _lable = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 25) WithTitle:title WithImageName:@"1"];
        [self.contentView addSubview:_collectionView];
        [self.contentView addSubview:_lable];
        
        [_collectionView registerClass:[Section4CollectionViewCell class] forCellWithReuseIdentifier:@"id"];
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

- (void)setDataArray:(NSMutableArray *)dataArray {
    
    _dataArray = dataArray;
   
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Section4CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.homeSection4DidSelectItemDelegate respondsToSelector:@selector(homeSection4DidSelectItemAtIndexPath:)]) {
        
        [self.homeSection4DidSelectItemDelegate homeSection4DidSelectItemAtIndexPath:indexPath];
    }
    
}

@end
