//
//  NSFileManager+PathMethod.m
//  abcd
//
//  Created by 钟高荣 on 14-8-28.
//  Copyright (c) 2014年 QF. All rights reserved.
//

#import "NSFileManager+PathMethod.h"

@implementation NSFileManager (PathMethod)
//类别方法，判断指定路径下得文件，是否超出了规定的时间
+(BOOL)isTimeOUtWithPath:(NSString *)path time:(NSTimeInterval) time{
//获取到指定路径下文件的属性。
    NSDictionary *dic = [[NSFileManager defaultManager]attributesOfItemAtPath:path error:nil];
//    获取文件的修改时间
    NSDate *date = [dic objectForKey:NSFileModificationDate];
//    获取系统当前时间
    NSDate *current = [NSDate date];
//    算出差值
    NSTimeInterval interval = [current timeIntervalSinceDate:date];
    if(interval >time){
//        超时
        return YES;
    }else{
        
        return NO;
    }
}
@end
