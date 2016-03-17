//
//  DBManager.h
//  abcd
//
//  Created by 钟高荣 on 14-8-31.
//  Copyright (c) 2014年 QF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject


+(DBManager *)shareManager;
//插入一条数据
-(void)insertDataWithObject:(id)obj withType:(NSString *)type;
//删除一条数据
-(void)deleteDataWithAppid:(NSString *)appid withType:(NSString *)type;
//获取到全部数据

-(NSMutableArray *)getObjectWithType:(NSString *)type;

//根据appID，看是否本条数据已经收藏
-(BOOL)isCollect:(NSString *)appid withType:(NSString *)type;
@end
