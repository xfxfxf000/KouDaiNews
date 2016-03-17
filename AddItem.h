//
//  AddItem.h
//  WXXNews
//
//  Created by qianfeng on 13-6-24.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddItem : NSObject
//id
@property (copy,nonatomic)NSString *ID;
//状态
@property (assign,nonatomic)BOOL state;
//title
@property (copy,nonatomic)NSString *title;
//url
@property (copy,nonatomic)NSString *url;
@end
