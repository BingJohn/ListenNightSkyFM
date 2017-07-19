//
//  ZyqTitleLable.m
//  FMMusic
//
//  Created by zyq on 16/1/12.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "ZyqTitleLable.h"

@implementation ZyqTitleLable
-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title WithColor:(UIColor *)color{
    if (self = [super initWithFrame:CGRectMake(0, 0, 100, 44)]) {
        
        self.text = title;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = color;
    }
    return self;
}


@end
