//
//  NormalTemplateViewController.h

#import <UIKit/UIKit.h>
#import "SQLOperate.h"
#import "JSONFileOperate.h"
#import "HeadCell.h"
#import "NormalCell.h"
#import "NotExistsImageCell.h"
#import "EGORefreshTableHeaderView.h"

@protocol  NormalVCDelegate<NSObject>

-(void)pushViewNewsInfoVC:(UIViewController *)vc;

@end

@interface NormalTemplateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,JSONFileOperateDelegate,HeadCellDelegate,EGORefreshTableHeaderDelegate>{
    NSMutableArray *_headDataArray;
    NSMutableArray *_normolDataArray;
    NSString *_url;
    NSString *_ID;
    EGORefreshTableHeaderView *_refreshView;
    
    BOOL isLoading;
    BOOL isScrolling;
    
    int nowRow;
    int befRow;
}
@property (nonatomic, retain) UITableView *tableView;
@property (assign ,nonatomic) id<NormalVCDelegate> delegate;
-(id)initWithID:(NSString *)ID;

@property (nonatomic,copy) NSString *ID;
-(void)setNewContentWithID:(NSString *)ID;

@end
