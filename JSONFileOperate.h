

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "MainPageItems.h"
#import "SQLOperate.h"

#define kDOWNLOAD_MAIN_PAGE_CONTENTS 100

@protocol JSONFileOperateDelegate <NSObject>
@required
-(void)downLoadFinsh:(NSMutableArray *)headArray andNormalArray:(NSMutableArray *)normalArray;

@end

@interface JSONFileOperate : NSObject<ASIHTTPRequestDelegate>
{
    NSString *_content;
    NSString *_urlStr;
    
}
//@property (retain, nonatomic) NSMutableDictionary *contDic;
@property (assign,nonatomic) id<JSONFileOperateDelegate> delegate;
-(id)initWithURL:(NSString *)urlStr;
-(void)downLoadDate:(NSString *)urlStr;
-(void)JSONFileAnalysis;
-(void)cancelRequest;

@end
