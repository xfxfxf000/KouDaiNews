//
//  SysInfo.m
//  WXXNews
//
//  Created by WangXiaoXiang on 13-6-27.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "SysInfo.h"

@implementation SysInfo


+(BOOL)timeCompare:(NSString *)dateStr andDay:(int)num{
    //取得当前时间
    NSDate *date = [NSDate date];
    NSMutableString *newDate =   [NSMutableString stringWithString:date.description];
    NSArray *tmpArray = [newDate componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- "]];
    [newDate deleteCharactersInRange:NSMakeRange(0, newDate.length)];
    for (int i=0; i<3; i++) {
        [newDate appendString:[tmpArray objectAtIndex:i]];
    }
    //取出传入的时间中的日期
    dateStr = [dateStr substringWithRange:NSMakeRange(0, 8)];
    
    //把日期进行比较
    if ([newDate intValue] - [dateStr intValue] > num) {
        return YES;
    }else{
        return NO;
    }
}
@end
