//
//  NotExistsImageCell.h

#import <UIKit/UIKit.h>
#import "MainPageItems.h"

@interface NotExistsImageCell : UITableViewCell

@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *digestLabel;
@property (nonatomic,retain) UILabel *replyLable;


-(void)setContentWithItem:(MainPageItems *)item;
@end
