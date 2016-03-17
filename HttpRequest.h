//
//  HttpRequest.h
//  abcd
//
//  Created by 钟高荣 on 14-8-28.
//  Copyright (c) 2014年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpRequest;
//声明协议
@protocol HttpRequestDelegate <NSObject>

-(void)requestFinished:(HttpRequest *)request;
-(void)requestFailed:(HttpRequest *)request;
@end

@interface HttpRequest : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,weak)id<HttpRequestDelegate> delegate;
@property(nonatomic,copy)NSString *urlString;
//下载的数据
@property(nonatomic,strong)NSMutableData *downData;
@property(nonatomic,assign)int tag;

+(HttpRequest *)requestDataWithString:(NSString *)urlString withTarget:(id<HttpRequestDelegate>)delegate;

+(HttpRequest *)requestDataWithString:(NSString *)urlString withTarget:(id<HttpRequestDelegate>)delegate andTag:(int)tag;

-(void)cancelRequest;
@end
