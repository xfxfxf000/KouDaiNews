//
//  CommentCell.h


#import <UIKit/UIKit.h>
#import "CommentItem.h"
#import "CacheOperate.h"
#import "AppendCommentLabel.h"
#import "ASIHTTPRequest.h"
#import "CacheOperate.h"


#define KTITLE_FONT_SIZE 12
#define KCOUNT_FONT_SIZE 12
#define KCONTENT_FONT_SIZE 12
@interface CommentCell : UITableViewCell<ASIHTTPRequestDelegate>
{
    float contentHeight[10];
    NSMutableArray *_arrayFrame;
}
@property (nonatomic, retain) UIImageView *headImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *countLabel;
@property (nonatomic, retain) AppendCommentLabel *lable1;
@property (nonatomic, retain) AppendCommentLabel *lable2;
@property (nonatomic, retain) AppendCommentLabel *lable3;
@property (nonatomic, retain) AppendCommentLabel *lable4;
@property (nonatomic, retain) AppendCommentLabel *lable5;
-(void)setContent:(NSArray *)array;
@end
