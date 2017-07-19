//
//  ContentFrame.m
//  FMMusic
//
//  Created by zyq on 16/1/10.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "ContentFrame.h"
#import "ZyqTools.h"

@implementation ContentFrame

- (void)setModelFrame:(ContentDataModel *)modelFrame {
    _modelFrame = modelFrame;
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
//    头像
    _avatarFrame = CGRectMake(xSpace, ySpace, 60, 60);
//    名字
    _nickNameFrame = CGRectMake(CGRectGetMaxX(_avatarFrame)+xSpace, ySpace, SCREENWIDTH- CGRectGetMaxX(_avatarFrame), 20);
//    评论
    CGFloat contentWidth = SCREENWIDTH - CGRectGetMaxX(_avatarFrame)-xSpace;
    CGFloat contentHeigh = [self sizeWithText:_modelFrame.content maxSize:CGSizeMake(contentWidth, MAXFLOAT) font:ZYQFONT(13)].height;
    
    _contentFrame = CGRectMake(CGRectGetMaxX(_avatarFrame)+xSpace, CGRectGetMaxY(_nickNameFrame)+ySpace, contentWidth, contentHeigh);
    
    _createdFrame = CGRectMake(CGRectGetMaxX(_avatarFrame)+xSpace, CGRectGetMaxY(_contentFrame)+ySpace, 100, 20);
    _cellHeight = CGRectGetMaxY(_createdFrame)+ySpace;
}

- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
@end
