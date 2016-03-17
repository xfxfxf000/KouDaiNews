//
//  AppendCommentLabel.h

#import <UIKit/UIKit.h>

#define kSIZE_WIDTH  self.bounds.size.width
#define kSIZE_HEIGHT self.bounds.size.height
#define kAPPEND_CONTENT_FONT_SIZE 11

@interface AppendCommentLabel : UIView
{
    float _contentHeight;
}
@property (nonatomic ,retain) UILabel *titleLabel;
@property (nonatomic ,retain) UILabel *contentLabel;
@property (nonatomic ,retain) UIImageView *background;

-(id)initWithFrame:(CGRect)frame andContentHeight:(CGFloat)height;
-(void)setTitleLabelFrame:(CGRect)rect;
@end
