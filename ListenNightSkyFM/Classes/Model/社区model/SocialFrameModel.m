//
//  SocialFrameModel.m
//  FMMusic
//
//  Created by zyq on 16/1/15.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "SocialFrameModel.h"
#import "ZyqTools.h"
#import "NSString+LableHeigh.h"

@implementation SocialFrameModel


-(void)setDataModel:(SocialDataModel *)dataModel {
    _dataModel = dataModel;
    NSArray * array = _dataModel.images;
    
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
//    头像
    _avatarFrame = CGRectMake(xSpace, ySpace, 40, 40);
//    名字
    _nickNameFrame = CGRectMake(CGRectGetMaxX(_avatarFrame)+xSpace, ySpace, 150, 15);
    
//    时间
    _timeFrame = CGRectMake(CGRectGetMaxX(_avatarFrame)+xSpace, CGRectGetMaxY(_nickNameFrame)+ySpace/2, 150, 15);

//    评论图片


    _commentnumFrame = CGRectMake(SCREENWIDTH-100, ySpace, 90, 20);
//    标题
    _titleFrame = CGRectMake(CGRectGetMaxX(_avatarFrame), CGRectGetMaxY(_timeFrame)+ySpace/2, SCREENWIDTH - xSpace *2, 15);
    
//    评论高度
    NSString * contenStr = _dataModel.content;
    CGFloat contenHeight;
    CGFloat contenWidth = SCREENWIDTH - xSpace *2;
    
    contenHeight = [contenStr sizeWithText:contenStr maxSize:CGSizeMake(contenWidth, MAXFLOAT) font:ZYQFONT(13)].height;
    
    if (contenHeight > 100) {
        contenHeight = 100;
    }
    _contentFrame = CGRectMake(xSpace, CGRectGetMaxY(_titleFrame)+ySpace/2, contenWidth, contenHeight);
    
    if (array.count !=0) {
        _imageViewFrame  = CGRectMake(2* xSpace , CGRectGetMaxY(_contentFrame)+ySpace/2, 80, 100);
        _cellHeight = CGRectGetMaxY(_imageViewFrame);
    }else {
        _imageViewFrame  = CGRectZero;
        _cellHeight = CGRectGetMaxY(_contentFrame);
    }
}

@end
