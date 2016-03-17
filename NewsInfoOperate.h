//
//  NewsInfoOperate.h


#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "NewsInfo.h"
#import "VideoItem.h"

@protocol NewsInfoOperateDelegate <NSObject>

-(void)downLoadFinish:(NewsInfo *)info;

@end
@interface NewsInfoOperate : NSObject<ASIHTTPRequestDelegate>
{
    NSString *_docid;
    NSMutableArray *_contentArray;
    NSMutableArray *_imgsrc;
    NSMutableArray *_videoArray;
    NSMutableArray *_contentAndTagArray;
}
@property(nonatomic,copy) NSString *contentStr;

@property (nonatomic,assign) id<NewsInfoOperateDelegate> delegate;

-(id)initWithDocid:(NSString *)docid;
-(void)downLoad;
-(void)contentStrAnalysis;
@end
