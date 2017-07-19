//
//  NSDate+CH.m
//  新闻
//
//  Created by Think_lion on 15/5/16.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "NSDate+CH.h"

@implementation NSDate (CH)


-(BOOL)isToday
{
    //     NSCalendar *calendar=[NSCalendar currentCalendar];  //当前日历
    //    int unit=NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    //    //获得微博创建时间的年月日(组件）
    //    NSDateComponents *createdCom=[calendar components:unit fromDate:self];
    //    //当前时间的组件（年 月  日）
    //    NSDateComponents *nowCom=[calendar components:unit fromDate:[NSDate date]];
    //   //是不是今天
    //    return (createdCom.year==nowCom.year) && (createdCom.month==nowCom.month)&&(createdCom.day==nowCom.day);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}
-(BOOL)isYesterday
{
    
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
    
}
-(BOOL)isThisYear
{
    //    NSCalendar *calendar=[NSCalendar currentCalendar];  //当前日历
    //    int unit= NSCalendarUnitYear;
    //    //获得微博创建时间的年月日(组件）
    //    NSDateComponents *createdCom=[calendar components:unit fromDate:self];
    //    //当前时间的组件（年 月  日）
    //    NSDateComponents *nowCom=[calendar components:unit fromDate:[NSDate date]];
    //    return (createdCom.year==nowCom.year) ;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

-(NSDateComponents *)deltaWithNow
{
    //     NSCalendar *calendar=[NSCalendar currentCalendar];  //当前日历
    //    int unit=NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    //    //返回微博发布时间到现在时间的差距  时分秒
    //    NSDateComponents *com=[calendar components:unit fromDate:self toDate:[NSDate date] options:0];
    //    return com;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
    
}
//返回日期yyyy-MM-dd的格式的日期
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}


@end
