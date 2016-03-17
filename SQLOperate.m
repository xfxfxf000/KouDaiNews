

#import "SQLOperate.h"

@implementation SQLOperate
-(BOOL)openDB{
    if (isOpened) {
        return YES;
    }
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/data.db"];
    //打开数据库
    db = [FMDatabase databaseWithPath:path];
    isOpened = [db open];
    if (isOpened) {
        //NSLog(@"数据打开！");
    }else{
        NSLog(@"数据库打开失败");
    }
    return isOpened;
}
-(void)closeDB{
    if (isOpened) {
        [db close];
    }
    isOpened = NO;

}
-(void)insertElementToMenuListWithID:(NSString *)ID andWihtTitle:(NSString *)title andWithState:(NSString *)state andWithURL:(NSString *)url{
    BOOL flag;
    flag = [self openDB];
    if (flag == NO) {
        NSLog(@"数据库打开失败！");
    }
    //创建表
    flag = [db executeUpdate:@"create table if not exists MenuList(id,title,state,url)"];
    if (flag == NO) {
        NSLog(@"创建表失败");
        [db close];
        return;
    }
    //插入数据
    if ([self findByID:ID fromTable:@"MenuList" andIDName:@"id"]) {
        NSLog(@"数据已经存在!,ID:%@",ID);
    }else{
        flag = [db executeUpdate:@"insert into MenuList values(?,?,?,?)",ID,title,state,url];
        if (flag == NO) {
            NSLog(@"数据库插入失败!");
        }
        //NSLog(@"数据插入成功!,ID:%@",ID);
    }
    
    [self closeDB];
}

-(BOOL)findByID:(NSString *)ID fromTable:(NSString *)tableName andIDName:(NSString *)IDName{
    NSString *sql = [NSString stringWithFormat:@"select *from %@ where %@=?",tableName,IDName];
    FMResultSet *set = [db executeQuery:sql,ID];
    return set.next;
}

-(void)updateToMenuListWithID:(NSString *)ID andWithState:(NSString *)state{
    BOOL flag;
    NSLog(@"%@",state);
    flag = [self openDB];
    if (flag == NO) {
        NSLog(@"数据库打开失败！");
    }
    //判断id是否存在
    if ([self findByID:ID fromTable:@"MenuList" andIDName:@"id"]) {
        flag = [db executeUpdate:@"update MenuList set state=? where id=?",state,ID];
    }else{
        NSLog(@"update,ID:%@不存在",ID);
    }
    [self closeDB];
}
//查找表是否存在
+(BOOL)findTable:(NSString *)tableName{
    BOOL flag;
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/data.db"];
    //打开数据库
    FMDatabase *tmpDB = [FMDatabase databaseWithPath:path];
    flag = [tmpDB open];
    if (tmpDB == NO) {
        NSLog(@"数据库打开失败");
    }
    NSString *sql = [NSString stringWithFormat:@"select *from %@",tableName];
    FMResultSet *set = [tmpDB executeQuery:sql];
    flag = [set next];
    return flag;
}
//读取menulist表中内容
+(NSArray *)loadMenuListData{
    //接收数组
    NSMutableArray *dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    BOOL flag;
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/data.db"];
    //打开数据库
    FMDatabase *tmpDB = [FMDatabase databaseWithPath:path];
    flag = [tmpDB open];
    if (tmpDB == NO) {
        NSLog(@"数据库打开失败");
    }
    NSString *sql = [NSString stringWithFormat:@"select *from MenuList"];
    FMResultSet *set = [tmpDB executeQuery:sql];
    while (set.next) {
        //格式化数据库数据
        AddItem *addItem = [[AddItem alloc]init];
        addItem.ID = [set stringForColumn:@"id"];
        addItem.title = [set stringForColumn:@"title"];
        addItem.state = [[set stringForColumn:@"state"]intValue];
        //NSLog(@"%d",addItem.state);
        addItem.url = [set stringForColumn:@"url"];
        [dataArray addObject:addItem];
        [addItem release];
    }
    return dataArray;
}

+(NSString *)getURLWithByID:(NSString *)ID fromTableName:(NSString *)tableName{
    NSString *url = nil;
    BOOL flag;
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/data.db"];
    //打开数据库
    FMDatabase *tmpDB = [FMDatabase databaseWithPath:path];
    flag = [tmpDB open];
    if (tmpDB == NO) {
        NSLog(@"数据库打开失败");
    }
    NSString *sql = [NSString stringWithFormat:@"select *from %@ where id=?",tableName];
    FMResultSet *set = [tmpDB executeQuery:sql,ID];
    while (set.next) {
        url = [set stringForColumn:@"url"];
    }
    [tmpDB close];
    return url;
}
//主页内容
-(BOOL)insertElementToTableName:(NSString *)tableName andWithDocid:(NSString *)docid andWithPtime:(NSString *)ptime andWithTitle:(NSString *)title andWithDigest:(NSString *)digest andWithHasHead:(NSString *)hasHead andWithImgsrc:(NSString *)imgsrc andWithReplyCount:(NSString *)replyCount andWithURLStr:(NSString *)url andWithTAG:(NSString *)TAG andLmodify:(NSString *)lmodify{
    BOOL flag;
    flag = [self openDB];
    if (flag == NO) {
        NSLog(@"数据库打开失败！");
        return NO;
    }
    //创建表
    //拼接sql语句
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(docid,ptime,title,digest,hasHead,imgsrc,replyCount,url,TAG,lmodify)",tableName];
    flag = [db executeUpdate:sql];
    if (flag == NO) {
        NSLog(@"创建%@表失败.",tableName);
        [self closeDB];
        return NO;
    }
    //插入内容之前查找改内容是否存在
    if ([self findByID:docid fromTable:tableName andIDName:@"docid"]) {
        //已经存在
        //NSLog(@"你插入的内容已经存在,tableName:%@",tableName);
        return NO;
    }else{
        //插入内容
        //拼接sql语句
        sql = [NSString stringWithFormat:@"insert into %@ values(?,?,?,?,?,?,?,?,?,?)",tableName];
        flag = [db executeUpdate:sql,docid,ptime,title,digest,hasHead,imgsrc,replyCount,url,TAG,lmodify];
        if (flag == NO) {
            NSLog(@"插入内容失败,tableName:%@",tableName);
        }
    }
    [self closeDB];
    return YES;
}
//更新一行内容
-(void)updateFromTableName:(NSString *)tableName andWithID:(NSString *)ID andWithReplyCount:(NSString *)replyCount{
    BOOL flag;
    flag = [self openDB];
    if (flag == NO) {
        NSLog(@"数据库打开失败！");
    }
    //拼接sql语句 update MenuList set state=? where id=?"
    NSString *sql = [NSString stringWithFormat:@"update %@ set replyCount=? where docid=?",tableName];
    flag = [db executeUpdate:sql,replyCount,ID];
    if (!flag) {
        NSLog(@"更新数据失败!,docid:%@",ID);
    }
    
    [self closeDB];
}
//删除一行
+(void)deleteRowFromTableName:(NSString *)tableName andWithID:(NSString *)ID andIDName:(NSString *)IDName{
    BOOL flag;
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/data.db"];
    //打开数据库
    FMDatabase *tmpDB = [FMDatabase databaseWithPath:path];
    flag = [tmpDB open];
    if (tmpDB == NO) {
        NSLog(@"数据库打开失败");
    }
    //拼接sql
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@=?",tableName,IDName];
    flag = [tmpDB executeUpdate:sql,ID];
    if (!flag) {
        NSLog(@"删除失败，ID:%@",ID);
    }else{
        NSLog(@"删除，ID:%@",ID);
    }
    
    [tmpDB close];
}
+(NSMutableDictionary *)loadMainPageDataFromTableName:(NSString *)tableName{
    //接收数组
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableArray *arrayHead = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *arrayNormal = [[NSMutableArray alloc]initWithCapacity:0];
    
    BOOL flag;
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/data.db"];
    //打开数据库
    FMDatabase *tmpDB = [FMDatabase databaseWithPath:path];
    flag = [tmpDB open];
    if (tmpDB == NO) {
        NSLog(@"数据库打开失败");
    }
    //拼接sql语句
    if ([SQLOperate findTable:tableName]) {
        NSString *sql = [NSString stringWithFormat:@"select *from %@ order by lmodify desc",tableName];
        FMResultSet *set = [tmpDB executeQuery:sql];
        //控制顶部视图的显示
        int i=1;
        while (set.next) {
            MainPageItems *item = [[MainPageItems alloc]init];
            //docid,ptime,title,digest,hasHead,imgsrc,replyCount,url,TAG
            item.docid = [set stringForColumn:@"docid"];
            item.ptime = [set stringForColumn:@"ptime"];
            if ([SysInfo timeCompare:item.ptime andDay:1]&&[item.docid isEqualToString:@"102vbo8005010001"] == NO) {
                [item release];
                continue;
            }
            item.title = [set stringForColumn:@"title"];
            item.digest = [set stringForColumn:@"digest"];
            item.imgsrc = [set stringForColumn:@"imgsrc"];
            item.replyCount = [set stringForColumn:@"replyCount"];
            item.url = [set stringForColumn:@"url"];
            item.TAG = [set stringForColumn:@"TAG"];
            //是否是在头部显示
//            if ([[set stringForColumn:@"hasHead"] isEqualToString:@"1"]) {
#warning 为了让顶部多显示点照片做出的决定
            if (i<=5) {
                item.hasHead = @"1";
                [arrayHead addObject:item];
            }else{
                item.hasHead = @"0";
                [arrayNormal addObject:item];
            }
            i++;
            [item release];
        }
    }else{
        NSLog(@"没有这张表:%@",tableName);
    }
    [tmpDB close];
    
    [dic setObject:arrayHead forKey:@"arrayHead"];
    [dic setObject:arrayNormal forKey:@"arrayNormal"];
    return dic;
}
- (void)dealloc
{
    [db release];
    [super dealloc];
}
@end
