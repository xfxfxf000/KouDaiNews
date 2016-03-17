//
//  HttpRequestManager.m
//  abcd
//
//  Created by 钟高荣 on 14-8-28.
//  Copyright (c) 2014年 QF. All rights reserved.
//

#import "HttpRequestManager.h"

static HttpRequestManager *manager;
@implementation HttpRequestManager
+(HttpRequestManager *)shareRequestManager{
    if(manager ==nil){
        manager = [[HttpRequestManager alloc]init];
    }
    return manager;
}

-(id)init{
    self = [super init];
    if(self){
        _httpRequestArray = [[NSMutableDictionary alloc]init];
    }
    return self;
}
-(void)addRequestWithObj:(id)object andKey:(NSString *)key{
   
    [_httpRequestArray setObject:object forKey:key];
}
-(void)removeRequestWithKey:(NSString *)key{
    [_httpRequestArray removeObjectForKey: key];
}

-(void)cancelRequestWithKey:(NSString *)string{
    HttpRequest *request = [_httpRequestArray objectForKey:string];
//    取消请求
    [request cancelRequest];
//    代理设置为空
    request.delegate =nil;
//    移除这个任务
    [_httpRequestArray removeObjectForKey:string];
    
}
@end
