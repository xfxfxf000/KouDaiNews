//
//  CreateAnimation.h
//  WXXNews
//
//  Created by WangXiaoXiang on 13-6-22.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZGRHeader.h"
@interface CreateAnimation : NSObject
//移动视图并且把view放到最底层
+(void)createAnimationWithView:(UIView *)view moveToFrame:(CGRect)frame target:(id)name selector:(SEL)sel;
+(void)dismissViewUseTime:(NSTimeInterval)time target:(id)name selector:(SEL)sel;
@end
