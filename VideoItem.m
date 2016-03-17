//
//  VideoItem.m
//  WXXNews
//
//  Created by WangXiaoXiang on 13-6-28.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "VideoItem.h"

@implementation VideoItem

- (void)dealloc
{
    [_alt release];
    [_url_mp4 release];
    [_cover release];
    [super dealloc];
}
@end
