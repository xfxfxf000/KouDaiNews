

#import "CommentOperate.h"

@implementation CommentOperate
- (void)dealloc
{
    [_content release];
    [_hotArray release];
    [_normalArray release];
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        _hotArray = [[NSMutableArray alloc]initWithCapacity:0];
        _normalArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}
//下载内容
-(void)downLoadCommentWithURL:(NSString *)urlStr andWithAnalysis:(analysisType)type {
    NSLog(@"url,%@",urlStr);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.delegate = self;
    request.tag = type;
    NSLog(@"开始下载:type:%d",type);
    [request startAsynchronous];
}
//下载完成
-(void)requestFinished:(ASIHTTPRequest *)request{
    _content = [[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    [self analysisJSONContent:(analysisType)request.tag];
    if ([self.delegate respondsToSelector:@selector(downLoadFinish:andType:) ]) {
        //代理传值
        if (request.tag == kNormal) {
            [self.delegate downLoadFinish:_normalArray andType:(analysisType)request.tag];
        }else{
            [self.delegate downLoadFinish:_hotArray andType:(analysisType)request.tag];
        }
    }
}
//下载失败
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"评论下载失败");
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
//按照类型解析内容
-(void)analysisJSONContent:(analysisType)type{
    
    NSDictionary *allInfo = [_content JSONValue];
    //普通类型
    if (type == kNormal) {
        [_normalArray removeAllObjects];
        NSArray *newPosts = [allInfo objectForKey:@"newPosts"];
        //NSLog(@"hotPosts.class,%@",newPosts.class);
        if ([newPosts isKindOfClass:NSClassFromString(@"NSNull")]) {
            NSLog(@"没有回帖!");
            return;
        }
        //第一层
        for (NSDictionary *dic in newPosts) {
            //定义一个临时数组
            NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithCapacity:0];
            //取出所有的key并排序
            NSArray *allKeys = [dic allKeys];
            
            allKeys = [allKeys sortedArrayUsingSelector:@selector(compare:)];
            //            NSLog(@"allKeys,%@",allKeys);
            for (id obj in allKeys) {
                //取出内容
                
                NSDictionary *tmpDic = [dic objectForKey:obj];
               // NSLog(@"tmpDic,%@",tmpDic.class);
                if ([tmpDic isKindOfClass:NSClassFromString(@"__NSCFString")]) {
                    NSLog(@"%@",tmpDic);
                    continue;
                }
                CommentItem *item = [[CommentItem alloc]init];
                item.name = [tmpDic objectForKey:@"n"];
                item.content = [[self deleteEleAtString:[tmpDic objectForKey:@"b"]] retain];
                item.from = [self deleteEleAtString:[tmpDic objectForKey:@"f"]];
                //这里需要装换一下
                item.time = [self getTime:[tmpDic objectForKey:@"t"]];
                
                item.count = [tmpDic objectForKey:@"v"];
                
                
                [tmpArray addObject:item];
                [item release];
            }
            [_normalArray addObject:tmpArray];
            [tmpArray release];
        }
    //热门类型
    }else if(type == kHot){
        [_hotArray removeAllObjects];
        NSArray *hotPosts = [allInfo objectForKey:@"hotPosts"];
        //NSLog(@"hotPosts.class,%@",hotPosts.class);
        if ([hotPosts isKindOfClass:NSClassFromString(@"NSNull")]) {
            NSLog(@"没有回帖!");
            return;
        }
        //第一层
        for (NSDictionary *dic in hotPosts) {
            //定义一个临时数组
            NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithCapacity:0];
            //取出所有的key并排序
            NSArray *allKeys = [dic allKeys];
            
            allKeys = [allKeys sortedArrayUsingSelector:@selector(compare:)];
//            NSLog(@"allKeys,%@",allKeys);
            for (id obj in allKeys) {
                //取出内容
                
                NSDictionary *tmpDic = [dic objectForKey:obj];
                if ([tmpDic isKindOfClass:NSClassFromString(@"__NSCFString")]) {
                    NSLog(@"%@",tmpDic);
                    continue;
                }
                CommentItem *item = [[CommentItem alloc]init];
                item.headImgSrc = [tmpDic objectForKey:@"timg"];
                item.name = [tmpDic objectForKey:@"n"];
                item.content = [[self deleteEleAtString:[tmpDic objectForKey:@"b"]] retain];
                item.from = [self deleteEleAtString:[tmpDic objectForKey:@"f"]];
                //这里需要装换一下
                item.time = [self getTime:[tmpDic objectForKey:@"t"]];
                item.count = [tmpDic objectForKey:@"v"];
                
                [tmpArray addObject:item];
                [item release];
                item = nil;
            }
            [_hotArray addObject:tmpArray];
        }
    }
}
-(NSString *)deleteEleAtString:(NSString *)aStr{
    NSMutableString *str = [[NSMutableString alloc]initWithString:aStr];
    
    NSRange range = [str rangeOfString:@"<br />"];
    while (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
        range = [str rangeOfString:@"<br />"];
    }
    range = [str rangeOfString:@"<br>"];
    while (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
        range = [str rangeOfString:@"<br>"];
    }
    range = [str rangeOfString:@"&gt;"];
    while (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
        range = [str rangeOfString:@"&gt;"];
    }
    range = [str rangeOfString:@"&times;"];
    while (range.location != NSNotFound) {
        [str replaceCharactersInRange:range withString:@" x "];
        range = [str rangeOfString:@"&times;"];
    }
    range = [str rangeOfString:@"&nbsp;"];
    while (range.location != NSNotFound) {
        [str replaceCharactersInRange:range withString:@" "];
        range = [str rangeOfString:@"&nbsp;"];  
    }
    return str;
}
@end
