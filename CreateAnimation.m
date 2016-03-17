//
//  CreateAnimation.m
//  WXXNews
//
//  Created by WangXiaoXiang on 13-6-22.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "CreateAnimation.h"


@implementation CreateAnimation
//出现动画
+(void)createAnimationWithView:(UIView *)view moveToFrame:(CGRect)frame target:(id)name selector:(SEL)sel{
    [UIView beginAnimations:@"wxx" context:nil];
    [UIView setAnimationDuration:kANIMATION_TIME];
    view.frame = frame;
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:kANIMATION_TIME target:name selector:sel userInfo:nil repeats:NO];
}
//几秒后组建消失
+(void)dismissViewUseTime:(NSTimeInterval)time target:(id)name selector:(SEL)sel{
    [NSTimer scheduledTimerWithTimeInterval:time target:name selector:sel userInfo:nil repeats:NO];
}
@end
