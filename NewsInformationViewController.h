

#import <UIKit/UIKit.h>
#import "NewsInfoOperate.h"
#import "NewsInfo.h"
#import "TitleCell.h"
#import "ContentCell.h"
#import "ShowImageViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CommentViewController.h"

@interface NewsInformationViewController : UIViewController<NewsInfoOperateDelegate,UITableViewDelegate,UITableViewDataSource,ContentCellDelegate,ShowImageDelegate>
{
    NSString *_docid;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NewsInfo *_newsInfo;
    ShowImageViewController *_showImageVC;
}
-(id)initWithDocid:(NSString *)docid;
@end
