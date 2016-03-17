//
//  AddViewController.h


#import <UIKit/UIKit.h>
#import "CreateButton.h"
#import "AddMenuCell.h"
#import "AddItem.h"
#import "ZGRViewConfig.h"
#import "SQLOperate.h"


@class AddViewController;
@protocol AddVCDelegate <NSObject>
@required
-(void)rightMenuReloadANDDismissAddVC:(AddViewController *)addVC;

@end

@interface AddViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    SQLOperate *_oper;
}
@property (assign ,nonatomic) id<AddVCDelegate> delegate;
@end
