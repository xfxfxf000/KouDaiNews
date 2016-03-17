//
//  TitleCell.h


#import <UIKit/UIKit.h>


#define kTITLE_LABEL_FONT_SIZE 18
#define kNORMAL_LABEL_FONT_SIZE 10


@interface TitleCell : UITableViewCell

@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *timeLabel;
@property (nonatomic,retain) UILabel *sourcesLabel;
@end
