//
//  ContentTwoFrameModel.m
//  FMMusic
//
//  Created by zyq on 16/1/16.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "ContentTwoFrameModel.h"
#import "ZyqTools.h"
#import "NSString+LableHeigh.h"
@implementation ContentTwoFrameModel

- (void)setDataModel:(SocialDataModel *)dataModel {
    _dataModel = dataModel;
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
    _avatarViewFrame = CGRectMake(xSpace, ySpace, 40, 40);
    _floorCountFrame = CGRectMake(CGRectGetMaxX(_avatarViewFrame)+xSpace, ySpace, SCREENHEIGHT - CGRectGetMaxY(_avatarViewFrame)-10, 20);
    CGFloat contentWidth = SCREENWIDTH - CGRectGetMaxX(_avatarViewFrame)-xSpace ;
    NSString * str = dataModel.content;
    CGFloat height  =[str sizeWithText:dataModel.content maxSize:CGSizeMake(contentWidth, MAXFLOAT) font:ZYQFONT(14)].height;
    
    _contentFrame =  CGRectMake(CGRectGetMaxX(_avatarViewFrame)+xSpace, CGRectGetMaxY(_avatarViewFrame)+ySpace, contentWidth, height);
    _timeLableFrame = CGRectMake(CGRectGetMaxX(_avatarViewFrame)+xSpace, CGRectGetMaxY(_contentFrame)+ySpace, 100, 20);
    _cellHeight = CGRectGetMaxY(_timeLableFrame)+ySpace;
    
}
@end
