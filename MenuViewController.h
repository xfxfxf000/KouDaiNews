//
//  MenuViewController.h


#import <UIKit/UIKit.h>
#import "ZGRViewConfig.h"

@class MenuViewController;
@protocol MenuViewDelegate <NSObject>

-(void)pushView;
-(void)setTitleAtMenuTableViewCellClicked:(NSString *)title andID:(NSString *)ID;

@end

@interface MenuViewController : UIViewController
{
    UITableView *_tableView;
    UIView *_keepOutView;
}

@property (assign ,nonatomic) id<MenuViewDelegate> delegate;
@end
