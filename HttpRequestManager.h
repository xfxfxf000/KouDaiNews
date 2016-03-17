//
//  HttpRequestManager.h
//  abcd
//
//  Created by 钟高荣 on 14-8-28.
//  Copyright (c) 2014年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
@interface HttpRequestManager : NSObject
{
    NSMutableDictionary *_httpRequestArray;
}

+(HttpRequestManager *)shareRequestManager;
-(void)addRequestWithObj:(id)object andKey:(NSString *)key;
-(void)removeRequestWithKey:(NSString *)key;

-(void)cancelRequestWithKey:(NSString *)string;
@end
