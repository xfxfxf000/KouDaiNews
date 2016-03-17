//
//  AddItem.m
//  WXXNews
//
//  Created by qianfeng on 13-6-24.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "AddItem.h"

@implementation AddItem
- (void)dealloc
{
    [_ID release];
    [_title release];
    [_url release];
    [super dealloc];
}
@end
