//
//  RightMenuViewController.h


#import "MenuViewController.h"
#import "RightMenuCell.h"
#import "CreateButton.h"
#import "AddViewController.h"
#import "SQLOperate.h"
#import "KDNavigationController.h"

@interface RightMenuViewController : MenuViewController<UITableViewDataSource,UITableViewDelegate,AddVCDelegate>
{
    NSMutableArray *_dataArray;
    BOOL isEditing;
}
@property (nonatomic, retain) UIView *addBackView;
@property (nonatomic, retain) UIButton *addButton;
@property (nonatomic, retain) UIButton *editButton;

@property (nonatomic, retain) KDNavigationController *addNC;



@end
