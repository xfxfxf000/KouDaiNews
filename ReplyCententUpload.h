//
//  ReplyCententUpload.h

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@interface ReplyCententUpload : NSObject<ASIHTTPRequestDelegate>
{
    NSString *_replyBoard;  //评论类型;
    NSString *_docid;   //文档类型;
    NSString *_url;
}
-(id)initWithURLStr:(NSString *)url andWithDocid:(NSString *)docid andWithRelyBoard:(NSString *)replyBoard;
-(void)uploadContent:(NSString *)content;
@end
