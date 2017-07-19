//
//  ZyqLable.m
//  FMMusic
//
//  Created by zyq on 16/1/4.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "ZyqLable.h"
#import "ZyqTools.h"

@implementation ZyqLable {
    NSString * _title;
    NSString * _nameString;
    UILabel * _titleLabel;
    UILabel * _lineLabel;

}

- (instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title WithImageName:(NSString *)nameString {
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
         _nameString = nameString;
         [self createAlloc];
    }
    return self;
}

- (void)createAlloc {
    _titleLabel = [UILabel new];
    _lineLabel = [UILabel new];
    [self addSubview:_lineLabel];
    [self addSubview:_titleLabel];
    [self createFrame];
    
}

- (void)createFrame {
    _lineLabel.frame = CGRectMake(0, 0, 5, self.frame.size.height);
    if ([_nameString isEqualToString:@"1"]) {
        _lineLabel.backgroundColor = [UIColor redColor];
    }else {
    _lineLabel.backgroundColor = [UIColor yellowColor];
        
    }
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_lineLabel.frame)+10, 5, self.frame.size.width, self.frame.size.height -10);
    _titleLabel.font = ZYQFONT(13);
    _titleLabel.text = _title;
    

}

@end
