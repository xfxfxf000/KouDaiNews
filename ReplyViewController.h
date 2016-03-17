//
//  replyViewController.h

#import <UIKit/UIKit.h>
#import "ReplyView.h"
#import "ReplyCententUpload.h"


@class ReplyViewController;
@protocol replyVCDelegate <NSObject>

-(void)dismissViewController:(ReplyViewController *)replyVC;


@end
@interface ReplyViewController : UIViewController<replyViewDelegate>
{
    ReplyView *_replyView;
    NSString *_replyBoard;  //评论类型;
    NSString *_docid;   //文档类型;
    NSString *_url;
}
@property (assign,nonatomic) id<replyVCDelegate> delegate;
-(id)initWIthDocid:(NSString *)docid andWithReplyBoard:(NSString *)replyBoard;
@end
