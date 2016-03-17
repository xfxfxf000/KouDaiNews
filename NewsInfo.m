//
//  NewsInfo.m
//  WXXNews
//
//  Created by WangXiaoXiang on 13-6-27.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "NewsInfo.h"

@implementation NewsInfo
- (void)dealloc
{
    [_contentArray release];
    [_title release];
    [_source release];
    [_ptime release];
    [_replyBoard release];
    [_replyCount release];
    [super dealloc];
}
@end
