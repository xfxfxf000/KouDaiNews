//
//  NewsInfoOperate.m


#import "NewsInfoOperate.h"

@implementation NewsInfoOperate

- (void)dealloc
{
    [_contentStr release];
    [_docid release];
    [_contentAndTagArray release];
    [_contentArray release];
    [_videoArray release];
    [super dealloc];
}

-(id)initWithDocid:(NSString *)docid{
    self = [super init];
    if (self) {
        _docid = docid;
    }
    return self;
}

-(void)downLoad{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",_docid]];
    NSLog(@"url:%@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
}
//下载的代理
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"下载失败!");
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    _contentStr = [[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    [self contentStrAnalysis];
}
-(void)contentStrAnalysis{
    NSDictionary *dic = [_contentStr JSONValue];
    NSDictionary *allInfo = [dic objectForKey:_docid];
    NewsInfo *infoItem = [[NewsInfo alloc]init];
    //标题
    NSString *title = [allInfo objectForKey:@"title"];
    //NSLog(@"title:%@",title);
    infoItem.title = title;
    //来源
    NSString *source = [allInfo objectForKey:@"source"];
   // NSLog(@"source:%@",source);
    infoItem.source = [NSString stringWithFormat:@"来源于:%@",source];
    //时间
    NSString *ptime = [allInfo objectForKey:@"ptime"];
    //NSLog(@"ptime:%@",ptime);
    infoItem.ptime = ptime;
    //bbs地址
    infoItem.replyBoard = [allInfo objectForKey:@"replyBoard"];
    
    //评论总数
    infoItem.replyCount = [allInfo objectForKey:@"replyCount"];
    NSString *body = [allInfo objectForKey:@"body"];
    //解析信息主体 1
    [self bodyAnalysis:body];
    //图片链接 2
    NSArray *img = [allInfo objectForKey:@"img"];
    [self imgArrayAnalysis:img];
    //3
    //取出视频链接
    NSArray *vArray = [allInfo objectForKey:@"video"];
    [self videoArrayAnalysis:vArray];
    
    //4
    [self replaceWithUrlAndVideo];
    //信息数组;
    infoItem.contentArray = _contentAndTagArray;
    [self.delegate downLoadFinish:infoItem];
}
//把字符串中的</br> ,和&gt;删除
-(NSString *)delegateEleAtString:(NSString *)aStr{
    NSMutableString *str = [[NSMutableString alloc]initWithString:aStr];
    
    NSRange range = [str rangeOfString:@"<br />"];
    while (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
        range = [str rangeOfString:@"<br />"];
    }
    
    
    range = [str rangeOfString:@"<b>"];
    while (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
        range = [str rangeOfString:@"<b>"];
    }
    
    
    range = [str rangeOfString:@"<!--link0-->"];
    while (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
        range = [str rangeOfString:@"<!--link0-->"];
    }
    
    
    range = [str rangeOfString:@"</b>"];
    while (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
        range = [str rangeOfString:@"</b>"];
    }
    
    range = [str rangeOfString:@"<strong>"];
    while (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
        range = [str rangeOfString:@"<strong>;"];
    }
    
    range = [str rangeOfString:@"</strong>"];
    while (range.location != NSNotFound) {
        [str deleteCharactersInRange:range];
        range = [str rangeOfString:@"</strong>;"];
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
    return str;
}
//1
-(void)bodyAnalysis:(NSString *)aStr{
    //把字符串中的</br> ,和&gt;删除
    
    aStr = [self delegateEleAtString:aStr];
    //
    _contentArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray *array = [aStr componentsSeparatedByString:@"<p>"];
    for (NSString *tmpStr in array) {
        //[str appendString:tmpStr];
        //NSLog(@"%@",tmpStr);
        NSArray *array2 = [tmpStr componentsSeparatedByString:@"</p>"];
        for (NSString *tmpStr2 in array2) {
            [_contentArray addObject:tmpStr2];
        }
    }
}
//2
-(void)imgArrayAnalysis:(NSArray *)array{
    _imgsrc = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary *dic in array) {
        [_imgsrc addObject:[dic objectForKey:@"src"]];
    }
} 
//遍历数组，把img替换为,url
//4
-(void)replaceWithUrlAndVideo{
    //[_contentArray removeAllObjects];
    //int i = 0 , j = 0;
    _contentAndTagArray = [[NSMutableArray alloc]initWithCapacity:0];
    [_contentArray removeObject:@""];
    for (int i=0,j=0,v=0; i<_contentArray.count; i++) {
        NSDictionary *tmpDic = nil;
        NSString *str = [_contentArray objectAtIndex:i];
        if ([str rangeOfString:@"<!--IMG"].location != NSNotFound) {
            tmpDic = [NSDictionary dictionaryWithObject:[_imgsrc objectAtIndex:j++] forKey:@"url"];
        }else if([str rangeOfString:@"<!--VIDEO"].location != NSNotFound){
            tmpDic = [NSDictionary dictionaryWithObject:[_videoArray objectAtIndex:v++] forKey:@"video"];
        }else{
            tmpDic = [NSDictionary dictionaryWithObject:str  forKey:@"text"];
        }
        [_contentAndTagArray addObject:tmpDic];
    }
    //NSLog(@"%@",_contentAndTagArray);
}
//3
//取出其中的视频链接
-(void)videoArrayAnalysis:(NSArray *)array{
    _videoArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary *dic in array) {
        VideoItem *item = [[VideoItem alloc]init];
        item.alt = [dic objectForKey:@"alt"];
        item.url_mp4 = [dic objectForKey:@"url_mp4"];
        item.cover = [dic objectForKey:@"cover"];
        NSLog(@"%@",item.alt);
        NSLog(@"%@",item.url_mp4);
        NSLog(@"%@",item.cover);
        [_videoArray addObject:item];
        [item release];
    }
}
@end
