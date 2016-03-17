

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "AddItem.h"
#import "MainPageItems.h"
#import "SysInfo.h"
@interface SQLOperate : NSObject
{
    FMDatabase *db;
    BOOL isOpened;
}
-(BOOL)openDB;
-(void)closeDB;
//查找表是否存在
+(BOOL)findTable:(NSString *)tableName;
//按照表名和id查找，数据库打开关闭操作，要使用本类的;
-(BOOL)findByID:(NSString *)ID fromTable:(NSString *)tableName andIDName:(NSString *)IDName;
//menuList表操作
-(void)insertElementToMenuListWithID:(NSString *)ID andWihtTitle:(NSString *)title andWithState:(NSString *)state andWithURL:(NSString *)url;


-(void)updateToMenuListWithID:(NSString *)ID andWithState:(NSString *)state;
+(NSArray *)loadMenuListData;

+(NSString *)getURLWithByID:(NSString *)ID fromTableName:(NSString *)tableName;

//主页内容操作

-(BOOL)insertElementToTableName:(NSString *)tableName andWithDocid:(NSString *)docid andWithPtime:(NSString *)ptime andWithTitle:(NSString *)title andWithDigest:(NSString *)digest andWithHasHead:(NSString *)hasHead andWithImgsrc:(NSString *)imgsrc andWithReplyCount:(NSString *)replyCount andWithURLStr:(NSString *)url andWithTAG:(NSString *)TAG andLmodify:(NSString *)lmodify;

+(NSMutableDictionary *)loadMainPageDataFromTableName:(NSString *)tableName;

-(void)updateFromTableName:(NSString *)tableName andWithID:(NSString *)ID andWithReplyCount:(NSString *)replyCount;

+(void)deleteRowFromTableName:(NSString *)tableName andWithID:(NSString *)ID andIDName:(NSString *)IDName;
@end
