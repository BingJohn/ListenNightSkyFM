//
//  FindSection2TableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/13.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "FindSection2TableViewCell.h"
#import "ZyqLable.h"
#import "ZyqTools.h"
#import "FindSection2Cell.h"

@implementation FindSection2TableViewCell {
    UICollectionView * _collectionView;
    ZyqLable * _lable;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        [self createCollectionView];
    }

    return self;
}

- (void)createCollectionView {
    
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
        _lable = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 25) WithTitle:@"主播" WithImageName:@"2"];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_lable.frame)+5,width, height - CGRectGetMaxY(_lable.frame)) collectionViewLayout:[self createLayout]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_collectionView];
    [self.contentView addSubview:_lable];
    
    [_collectionView registerClass:[FindSection2Cell class] forCellWithReuseIdentifier:@"id"];
    
    [_collectionView reloadData];
}

- (void)layoutSubviews {
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    _lable.frame = CGRectMake(0, 0,width, 25);
    _collectionView.frame = CGRectMake(0, CGRectGetMaxY(_lable.frame)+5,width, height - CGRectGetMaxY(_lable.frame));
}

- (UICollectionViewFlowLayout *)createLayout {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat ySapce = 10;
    CGFloat width = (SCREENWIDTH -1*ySapce) /2-10;
    
    //这个时候的cell 高度是44  出列cell的高度150值 还没给上 只能用数字表达
    CGFloat height = 70;
    layout.itemSize =CGSizeMake(width, height);
    
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 5);
    return layout;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    
    _dataArray = dataArray;
     [_collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FindSection2Cell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    DianTaiModel * model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.findHostSectionDidSelectItemDelegate  respondsToSelector:@selector(findHostSectionDidSelectItemAtIndexPath:)]) {
        
        [self.findHostSectionDidSelectItemDelegate findHostSectionDidSelectItemAtIndexPath:indexPath];
    }
}

@end
