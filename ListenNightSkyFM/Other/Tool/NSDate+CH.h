//
//  NSDate+CH.h
//  新闻
//
//  Created by Think_lion on 15/5/16.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CH)

//判断是否为今天
-(BOOL)isToday;
//判断是否为昨天
-(BOOL)isYesterday;
//判断是否为今年
-(BOOL)isThisYear;
//获得与当前时间的差距
-(NSDateComponents *)deltaWithNow;

- (NSDate *)dateWithYMD;



@end
