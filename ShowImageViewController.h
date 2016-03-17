//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class ShowImageViewController;
@protocol ShowImageDelegate <NSObject>
-(void)touchesBegan:(ShowImageViewController *)showImageVC;

@end

@interface ShowImageViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIImage *_image;
    UIImageView *_imageView;
}
-(id)initWithImage:(UIImage *)image;
@property (assign,nonatomic) id<ShowImageDelegate> delegate;
@end
