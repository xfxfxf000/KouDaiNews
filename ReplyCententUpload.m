

#import "ReplyCententUpload.h"

@implementation ReplyCententUpload
-(id)initWithURLStr:(NSString *)url andWithDocid:(NSString *)docid andWithRelyBoard:(NSString *)replyBoard{
    self = [super init];
    if (self) {
        _url = url;
        _docid = docid;
        _replyBoard = replyBoard;
    }
    return self;
}

-(void)uploadContent:(NSString *)content{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:_url]];
    request.delegate = self;
    //论坛类型
    [request setPostValue:_replyBoard forKey:@"board"];
    NSLog(@"board=%@",_replyBoard);
    //文档类型
    [request setPostValue:_docid forKey:@"threadid"];
    NSLog(@"threadid=%@",_docid);
    //内容
    [request setPostValue:[request encodeURL:content] forKey:@"body"];
    //用户id
    [request setPostValue:[request encodeURL:@"lqiaoyue@163.com"] forKey:@"userid"];
    //昵称
    [request setPostValue:[request encodeURL:@"新闻客户端用户"]forKey:@"nickname"];
    //ip
    [request setPostValue:@"0.0.0.0" forKey:@"ip"];
    [request setPostValue:@"ph" forKey:@"from"];
    [request setPostValue:@"false" forKey:@"hidename"];
    [request startAsynchronous];
//    NSString *str = @"新闻客户端用户";
//    NSLog(@"%@",[request encodeURL:str]);
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"上传失败！");
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"request,%@",request.responseString);
}
@end
