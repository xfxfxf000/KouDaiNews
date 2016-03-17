//
//  AddMenuCell.h


#import <UIKit/UIKit.h>
#import "CreateButton.h"
#import "SQLOperate.h"

@interface AddMenuCell : UITableViewCell
{
    BOOL isCheckmark;
}
@property (retain, nonatomic) UILabel *titleLable;
@property (retain, nonatomic) UIButton *addButton;
@property (copy, nonatomic) NSString *ID;

-(void)setStateToButton:(BOOL) yesOrNO;

@end
