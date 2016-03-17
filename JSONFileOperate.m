
#import "JSONFileOperate.h"

@implementation JSONFileOperate
{
    ASIHTTPRequest *_request;
}
- (void)dealloc
{
    [_urlStr release];
    [_content release];
//    [_contDic release];
    [super dealloc];
}

-(id)initWithURL:(NSString *)urlStr{
    self = [super init];
    if (self) {
        _urlStr = urlStr;
    }
    return self;
}
-(void)downLoadDate:(NSString *)urlStr{
    NSLog(@"正要下载。。。");
    _urlStr = urlStr;
    NSLog(@"%@",_urlStr);
    if (_urlStr.length<10) {
        return;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    _request = [ASIHTTPRequest requestWithURL:url];
    _request.delegate = self;
    _request.tag  = kDOWNLOAD_MAIN_PAGE_CONTENTS;
    [_request startAsynchronous];
    
}

-(void)cancelRequest{
    [_request cancel];
}
//下载的代理
//下载完成
-(void)requestFinished:(ASIHTTPRequest *)request{
    //NSLog(@"下载完成");
    if (request.tag == kDOWNLOAD_MAIN_PAGE_CONTENTS) {
        _content = [[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
        [self JSONFileAnalysis];
    }
}
//下载失败
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"下载失败!");
}

//从url中 取出数组名称,只能解析主页数据
-(NSString *)getArrayName{
    NSArray *tmpArray = [_urlStr componentsSeparatedByString:@"/"];
    return [tmpArray objectAtIndex:[tmpArray count]-2];
}
//格式化时间
-(NSString *)getTime:(NSString *)time{
    NSArray *tmpArray = [time componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- :"]];
   // NSLog(@"%@",tmpArray);
    NSMutableString *tmpString = [[NSMutableString alloc]initWithCapacity:0];
    for (NSString *str in tmpArray) {
        [tmpString appendString:str];
    }
    //NSLog(@"%@",tmpString);
    return tmpString;
}
//解析下载数据
-(void)JSONFileAnalysis{
    BOOL flag;

    //开始解析
//    NSLog(@"%@",_content);
    NSDictionary *dic = [_content JSONValue];
//    NSLog(@"%d",dic.count);
    NSString *MainPageID = [self getArrayName];
//    NSLog(@"MainPageID:%@",MainPageID);
    NSArray *tmpArray = [dic objectForKey:MainPageID];
//    NSLog(@"%d",tmpArray.count);
    //取每一项的内容
    for (NSDictionary *itemDic in tmpArray) {
        MainPageItems *item = [[MainPageItems alloc]init];
        //文档id
        item.docid = [itemDic objectForKey:@"docid"];
        //提交时间
        item.ptime = [self getTime:[itemDic objectForKey:@"ptime"]];
        //修改时间
        item.lmodify = [self getTime:[itemDic objectForKey:@"lmodify"]];
        //标题
        item.title = [itemDic objectForKey:@"title"];
        //副标题
        item.digest = [itemDic objectForKey:@"digest"];
        //是否在头部显示
        item.hasHead = [NSString stringWithFormat:@"%@",[itemDic objectForKey:@"hasHead"]];
        //NSLog(@"%@",item.hasHead);
        //图片地址
        item.imgsrc = [itemDic objectForKey:@"imgsrc"];
        //回复数量
        item.replyCount = [itemDic objectForKey:@"replyCount"];
        //顺序
        item.priority = [itemDic objectForKey:@"priority"];
        //内容地址
        item.url = [itemDic objectForKey:@"url"];
        //标签
        item.TAG = [itemDic objectForKey:@"TAG"];
        //在这需要插入数据库
        SQLOperate *oper = [[SQLOperate alloc]init];
        
        flag = [oper insertElementToTableName:MainPageID andWithDocid:item.docid andWithPtime:item.ptime andWithTitle:item.title andWithDigest:item.digest andWithHasHead:item.hasHead andWithImgsrc:item.imgsrc andWithReplyCount:item.replyCount andWithURLStr:item.url andWithTAG:item.TAG andLmodify:item.lmodify];
        if (!flag) {
            [oper updateFromTableName:MainPageID andWithID:item.docid andWithReplyCount:item.replyCount];
        }
    }

    dic = [SQLOperate loadMainPageDataFromTableName:MainPageID];
    
    [self.delegate downLoadFinsh:[dic objectForKey:@"arrayHead"] andNormalArray:[dic objectForKey:@"arrayNormal"]];
}
@end
