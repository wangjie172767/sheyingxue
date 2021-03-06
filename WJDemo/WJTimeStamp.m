//
//  WJTimeStamp.m
//  WJDemo
//
//  Created by jie wang on 16/2/3.
//  Copyright © 2016年 jie wang. All rights reserved.
//

#import "WJTimeStamp.h"

@implementation WJTimeStamp

+ (NSString *)timeFormatter:(NSTimeInterval )timeInterval
{
    
    //设置时间显示格式:
    //    NSString* timeStr = @"2011-01-26 17:40:50";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    // 时间戳转时间的方法1413388800000 1413253534
    timeInterval = timeInterval+63072000+15552000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    //    NSLog(@"%f = %@",_firstPlayTime,confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    //    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    
    //1386655613 2013.12.10
    /*
     //设置时区,这个对于时间的处理有时很重要
     //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
     //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
     //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
     NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
     [formatter setTimeZone:timeZone];
     
     NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
     
     NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
     NSLog(@"datenow :%@",datenow);
     
     NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
     
     // 时间转时间戳的方法:
     NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
     NSLog(@"timeSp:%@",timeSp); //时间戳的值
     
     //时间戳转时间的方法:
     NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
     [formatter1 setDateStyle:NSDateFormatterMediumStyle];
     [formatter1 setTimeStyle:NSDateFormatterShortStyle];
     [formatter1 setDateFormat:@"yyyyMMdd"];
     NSDate *date1 = [formatter1 dateFromString:@"1413475200000"];
     NSLog(@"date1:%@",date1);
     */
    return confromTimespStr;
}


@end
