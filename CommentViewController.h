//
//  CommentViewController.h

//

#import <UIKit/UIKit.h>
#import "CommentItem.h"
#import "CommentOperate.h"
#import "CommentCell.h"
#import "ReplyViewController.h"
#import "CreateButton.h"

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CommentOperateDelegate,replyVCDelegate>
{
    int num;//查看评论数量默认为10
    NSString *_replyBoard;  //评论类型;
    NSString *_docid;   //文档类型;
    NSString *_urlNormal;//下载评论的链接地址
    NSString *_urlHot;
    UITableView *_tableView;
    //热门评论内容
    NSMutableArray *_hotCommentArray;
    //普通评论内容
    NSMutableArray *_normalCommentArray;
    //评论操作
    CommentOperate *_commentOper;
    //记录上一次的坐标
    CGPoint befPoint;
    ReplyViewController *_replyVC;
}

-(id)initWithDocid:(NSString *)docid andWithReplyBoard:(NSString *)replyBoard;
@end
