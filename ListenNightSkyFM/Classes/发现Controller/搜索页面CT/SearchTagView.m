//
//  SearchTagView.m
//  FMMusic
//
//  Created by zyq on 16/1/14.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "SearchTagView.h"
#import "HeadViewModel.h"
#import "ZyqTools.h"
#import "NSString+Common.h"
#import "AppDelegate+Common.h"
#import "HotSearchViewController.h"
@implementation SearchTagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self ) {
        [self createTags];
    }
    
    return self;
}



- (void)createTags {
    

}
- (void)setDataArray:(NSMutableArray *)dataArray {

    _dataArray = dataArray;
    
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
     int i2 = 0;
     int j = 0;
     CGFloat width = (SCREENWIDTH - (xSpace * 5))/4;
      CGFloat lastWidth = 0;
    NSString * str = nil;
//    for (int i = 0; i < _dataArray.count; i++) {
//        
//        HeadDataModel * model = _dataArray[i];
//#warning !!!!  搞不懂 真tm蠢
//         str = model.name;
//        if (str.length > 2) {
//            width = 2*width;
//        }
//        
//        if (lastWidth == 0) {
//            lastWidth = width;
//        }
//        
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = i ;
//        button.frame = CGRectMake((xSpace+lastWidth)*(i2%4)+xSpace, ySpace+(ySpace +20) * (j/4), width, 20);
//        
//        if (CGRectGetMaxX(button.frame) > SCREENWIDTH - 10) {
//            
//            i2 =4 *count+i;
//            j = 4 * count+i;
//            button.frame = CGRectMake((xSpace+0), ySpace+(ySpace +20) * (j/4), width, 20);
//            count ++;
//        }
//        i2 ++;
//        j++;
//        
//        lastWidth = CGRectGetWidth(button.frame);
//        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor redColor];
////        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [self addSubview:button];
//    }
    
//    九宫格 带点不固定的frame宽度
    
    CGFloat height = 30;
    for (int i = 0; i < _dataArray.count; i++) {
        HeadDataModel * model = _dataArray[i];
        str  = model.name;
        if (str.length > 2) {
            width = 1.2*width;
        }
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xSpace  + (xSpace + lastWidth) *i2, ySpace + (ySpace + height)* j, width, height);
        if (CGRectGetMaxX(button.frame)  > SCREENWIDTH - 10) {
            i2 = 0;
            j ++;
            button.frame =CGRectMake(xSpace  + (xSpace + lastWidth) *i2, ySpace + (ySpace + height)* j, width, height);
        }
        i2 ++;
        lastWidth = CGRectGetWidth(button.frame);;
        [button setTitle:str forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.layer.cornerRadius = 10;
        button.layer.borderWidth =1.0;
        button.clipsToBounds = YES;
        button.titleLabel.font = ZYQFONT(13);
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//        button.backgroundColor = [UIColor redColor];
//        button.showsTouchWhenHighlighted = YES;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    
}

- (void)buttonClick:(UIButton *)button {
    
    NSInteger tag = button.tag;
    HeadDataModel * model = _dataArray[tag];
    
    NSString * str = URLEncodedString(model.name);
    HotSearchViewController * searchVC = [[HotSearchViewController alloc]init];
    searchVC.url = str;
    searchVC.titleNmae = model.name;
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.nvc pushViewController:searchVC animated:YES];

}

@end
