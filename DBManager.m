////
////  DBManager.m
////  abcd
////
////  Created by 钟高荣 on 14-8-31.
////  Copyright (c) 2014年 QF. All rights reserved.
////
//
#import "DBManager.h"
#import "FMDatabase.h"

static DBManager *manager=nil;
@implementation DBManager
{
    FMDatabase *_database;
}

-(id)init{
    self = [super init];
    if(self){
        NSString *path  =NSHomeDirectory();
        NSString *dbPath = [path stringByAppendingFormat:@"/Documents/photo.db"];
        _database = [[FMDatabase alloc]initWithPath:dbPath];
        if([_database open]){ // 成功了
//        创建表
            NSLog(@"数据库创建成功");
//            category comments Id intro pubDate title   playnumber runtime url video_id
            NSString *sql = @"create table if not exists photoInfo(squareimgurl varchar(256),note varchar(256),type varchar(256))";
            
//      category,comments,Id,intro,pubDate,title,playnumber ,runtime,url,video_id
           BOOL success =  [_database executeUpdate:sql];
            if(success){
                NSLog(@"创建成功");
            }else{
            
                NSLog(@"表格创建失败了");;
            }
        }else{
//            失败了
            NSLog(@"数据库创建失败%@",_database.lastErrorMessage);
        }
        
    }
    return self;
}
+(DBManager *)shareManager{
    
    if(manager == nil){
        manager = [[DBManager alloc]init];
    }
    return manager;
}
//插入一条数据
-(void)insertDataWithObject:(id)obj withType:(NSString *)type{
    
//    看这个Obj是不是属于detailmodel.
//    if ([obj isKindOfClass:[PhotoDetailModel class]]) {
//        PhotoDetailModel *model = (PhotoDetailModel *)obj;
//        NSString *sql = @"insert into photoInfo(squareimgurl,note,type) values (?,?,?)";
//        BOOL isSuccess = [_database executeUpdate:sql,model.squareimgurl,model.note,type];
//        if(isSuccess){
//        
//            NSLog(@"insert success");
//        }else{
//        
//            NSLog(@"error %@",_database.lastErrorMessage);
//        }
//    }
}
//删除一条数据
-(void)deleteDataWithAppid:(NSString *)appid withType:(NSString *)type{
     NSString *sql = @"delete from photoInfo where squareimgurl=?&type=?";
      BOOL isSuccess =[_database executeUpdate:sql,appid,type];
    if(isSuccess){
        NSLog(@"删除成功");
        
    }else{
        NSLog(@"删除失败");
    }
}
//获取到全部数据
-(NSMutableArray *)getObjectWithType:(NSString *)type{
    NSString *sql = @"select * from photoInfo where type=?";
    FMResultSet *set = [_database executeQuery:sql,type];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    while ([set next]) {
//        PhotoDetailModel *model = [[PhotoDetailModel alloc]init];
//        model.squareimgurl = [set stringForColumn:@"squareimgurl"];
//        model.note = [set stringForColumn:@"note"];
//        [array addObject:model];
    }
    return array;
}
//根据appID，看是否本条数据已经收藏
    //根据appID，看是否本条数据已经收藏
-(BOOL)isCollect:(NSString *)appid withType:(NSString *)type
    {
    NSString *string = @"select * from photoInfo where squareimgurl=?&type=?";
    FMResultSet *result = [_database executeQuery:string,appid,type];
    return [result next];
}
@end
    
