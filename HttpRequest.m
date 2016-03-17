//
//  HttpRequest.m
//  abcd
//
//  Created by 钟高荣 on 14-8-28.
//  Copyright (c) 2014年 QF. All rights reserved.
//

#import "HttpRequest.h"
#import "HttpRequestManager.h"
#import "NSString+Hashing.h"
#import "NSString+MD5Addition.h"
#import "NSFileManager+PathMethod.h"
@implementation HttpRequest
{
    NSURLConnection *_connection;
    
}

-(id)init{
    self = [super init];
    if(self){
        _downData = [[NSMutableData alloc]init];

    }
    return self;
}

+(HttpRequest *)requestDataWithString:(NSString *)urlString  withTarget:(id<HttpRequestDelegate>)delegate{
    return [self requestDataWithString:urlString withTarget:delegate andTag:0];
}

+(HttpRequest *)requestDataWithString:(NSString *)urlString withTarget:(id<HttpRequestDelegate>)delegate andTag:(int)tag{
 
    HttpRequest *request = [[HttpRequest alloc]init];
    request.delegate =delegate;
    request.urlString = urlString;
    request.tag = tag;
    //    看是否超时.
    //    [NSFileManager isTimeOUtWithPath: time:60*60];
    //    看文件是否存在
    NSString *path = [HttpRequest isExistsPathForString:urlString];
    //    判断文件在本地是否存在，并且最后修改得时间，有没有超出缓存时间，没有的话，就直接加载本地的信息
    //    [NSFileManager isTimeOUtWithPath:path time:60*60]
    if([[NSFileManager defaultManager]fileExistsAtPath:path] && [NSFileManager isTimeOUtWithPath:path time:60*60*60]){
        
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        [request.downData setLength:0];
        [request.downData appendData:data];
        if([delegate respondsToSelector:@selector(requestFinished:)]){
            [delegate requestFinished:request];
        }
        return request;
    }else{}
    //        如果不满足的话，就去请求数据，并加入任务队列中去
    [request startRequest];
    [[HttpRequestManager shareRequestManager]addRequestWithObj:request andKey:urlString];
    return request;
 }

+(NSString *)isExistsPathForString:(NSString *)filePath{

    return  [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",[filePath MD5Hash]];;
}
//下载数据
-(void)startRequest{
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    _connection = [[NSURLConnection alloc]initWithRequest:request  delegate:self];
    
}

#pragma mark NSUrlConnection Url
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_downData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_downData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error");
    if([_delegate respondsToSelector:@selector(requestFailed:)]){
        [_delegate requestFailed:self];
    }
    //    从任务队列中移除
    [[HttpRequestManager shareRequestManager]removeRequestWithKey:_urlString];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
//    写入文件中去
    [_downData writeToFile:[HttpRequest isExistsPathForString:_urlString] atomically:YES];
    
    
    if([_delegate respondsToSelector:@selector(requestFinished:)]){
        [_delegate requestFinished:self];
    }
//    从任务队列中移除
    [[HttpRequestManager shareRequestManager]removeRequestWithKey:_urlString];
}

-(void)cancelRequest{
    if(_urlString){
//    取消请求
        [_connection cancel];
        _connection = nil;
    }
}
@end
