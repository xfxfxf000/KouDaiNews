//
//  CommentItem.h
//  WXXNews
//
//  Created by WangXiaoXiang on 13-7-1.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentItem : NSObject
@property (nonatomic ,copy) NSString *time;
@property (nonatomic ,copy) NSString *headImgSrc;
@property (nonatomic ,copy) NSString *from;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *content;
@property (nonatomic ,copy) NSString *count;
@end
