

#import <UIKit/UIKit.h>
#import "ZGRHeader.h"
#import "ZGRViewConfig.h"
#import "SQLOperate.h"
#import "ParentsViewController.h"
#import "KDNavigationController.h"

@interface RootViewController : UIViewController<MenuViewDelegate,UIGestureRecognizerDelegate>
{
    KDNavigationController *_contentNavigationController;
//    ContentViewController *_contentViewController;
    
    BOOL isToRigth;
    BOOL isToLeft;
    
    RightMenuViewController *_rightMenuVC;
    SQLOperate *_oper;

    CGPoint befPt;
}

@end
