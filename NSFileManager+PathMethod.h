//
//  NSFileManager+PathMethod.h
//  abcd
//
//  Created by 钟高荣 on 14-8-28.
//  Copyright (c) 2014年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (PathMethod)
//类别方法，判断指定路径下得文件，是否超出了规定的时间
+(BOOL)isTimeOUtWithPath:(NSString *)path time:(NSTimeInterval) time;
@end
