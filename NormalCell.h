//
//  NormalCell.h

#import <UIKit/UIKit.h>
#import "MainPageItems.h"
@interface NormalCell : UITableViewCell

@property (nonatomic,retain) UIImageView *mImageView;
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *digestLabel;

@property (nonatomic,retain) UILabel *replyLable;

-(void)setContentWithItem:(MainPageItems *)item;

-(void)setContentWIthItemOnlyWordage:(MainPageItems *)item;


-(void)setImageWithURLString:(NSString *)urlStr;
@end
