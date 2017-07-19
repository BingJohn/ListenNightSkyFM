//
//  SectionTwoTableViewCell.m
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "SectionTwoTableViewCell.h"
#import "ZyqLable.h"
#import "ZyqTools.h"
#import "ZyqSectionTwoCollectionViewCell.h"

@implementation SectionTwoTableViewCell {

    UICollectionView * _collectionView;
    ZyqLable * _lable;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _collectionView  = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:[self createLayout] ];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _lable = [[ZyqLable alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 25) WithTitle:@"精彩推荐" WithImageName:@"11"];
        [self.contentView addSubview:_collectionView];
        [self.contentView addSubview:_lable];
        
        [_collectionView registerClass:[ZyqSectionTwoCollectionViewCell class] forCellWithReuseIdentifier:@"id"];
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
    CGFloat width = (SCREENWIDTH -2*ySapce) /3-10;
    
    //这个时候的cell 高度是44  出列cell的高度150值 还没给上 只能用数字表达
    CGFloat height = 100;
    layout.itemSize =CGSizeMake(width, height);

    
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 5);
    return layout;
}

- (void)setHotFMArray:(NSArray *)hotFMArray {
    
    _hotFMArray = hotFMArray;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _hotFMArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZyqSectionTwoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    
    cell.model = _hotFMArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.homeSectionTwoDidSelectItemDelegate respondsToSelector:@selector(homeSectionTwoDidSelectItemAtIndexPath:)]) {
        
        [self.homeSectionTwoDidSelectItemDelegate homeSectionTwoDidSelectItemAtIndexPath:indexPath];
    }
}

@end
