//
//  NewsInfo.h
//  WXXNews
//
//  Created by WangXiaoXiang on 13-6-27.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoItem.h"
@interface NewsInfo : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *source;
@property (nonatomic, copy)NSString *ptime;
@property (nonatomic, copy)NSString *replyBoard;
@property (nonatomic, copy)NSString *replyCount;
@property (nonatomic,retain) NSMutableArray *contentArray;

@end
