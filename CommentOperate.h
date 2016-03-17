

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"

#import "CommentItem.h"
//按照什么样的类型解析
typedef enum{
    kNormal = 101,
    kHot = 102,
}analysisType;

@protocol CommentOperateDelegate <NSObject>

-(void)downLoadFinish:(NSMutableArray *)mArray andType:(analysisType)type;

@end

@interface CommentOperate : NSObject<ASIHTTPRequestDelegate>
{
    //下载完成后的内容
    NSString *_content;
    //存储解析完成后内容
    NSMutableArray *_hotArray;
    //存储解析完成后内容
    NSMutableArray *_normalArray;
}
//下载解析完成后代理传值
@property (nonatomic,assign) id<CommentOperateDelegate> delegate;
//下载评论
-(void)downLoadCommentWithURL:(NSString *)urlStr andWithAnalysis:(analysisType )type;

//解析评论
-(void)analysisJSONContent:(analysisType) type;
@end
