//
//  CommentItem.m
//  WXXNews
//
//  Created by WangXiaoXiang on 13-7-1.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "CommentItem.h"

@implementation CommentItem
- (void)dealloc
{
    [_content release];
    [_time release];
    [_headImgSrc release];
    [_name release];
    [_from release];
    [super dealloc];
}
@end
