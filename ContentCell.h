//
//  ContentCell.h


#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CacheOperate.h"
#import "VideoItem.h"
#import "CreateButton.h"

#define kCONTENT_FONT_SIZE 15
#define kNORMAL_IMAGE 100
#define kPLAYER_COVER 200

typedef enum{
    Normal,
    Video,
}OpenType;

@protocol ContentCellDelegate <NSObject>

-(void)selectedImage:(UIImage *)image andType:(OpenType) type otherURL:(NSString *)url;

@end

@interface ContentCell : UITableViewCell<ASIHTTPRequestDelegate>
{
    NSString *_imgSrc;
    NSString *_url_mp4;
}
@property (nonatomic,retain) UILabel *contentLabel;
@property (nonatomic,retain) UIImageView *mImageView;
@property (nonatomic,retain) UIImageView *playerImageView;
@property (nonatomic,retain) UILabel *playerTitle;
@property (nonatomic,retain) UIView *playerView;

@property (nonatomic,retain) id<ContentCellDelegate> delegate;

-(void)setPlayerInfo:(VideoItem *)videoItem;
-(void)setImageWithURL:(NSString *)url;
@end
