//
//  HeadCell.h


#import <UIKit/UIKit.h>
#import "MainPageItems.h"
#import "ASIHTTPRequest.h"
#import "CacheOperate.h"
#import "SysInfo.h"
#import "SQLOperate.h"
#import "NewsInformationViewController.h"
#define kHEAD_CELL_TITLE_FONT_SIZE 13


@protocol HeadCellDelegate <NSObject>

-(void)pushView:(UIViewController *)vc;

@end

@interface HeadCell : UITableViewCell<ASIHTTPRequestDelegate,UIScrollViewDelegate>
{
    int _count; //头部显示新闻数量
    
    NSMutableArray *_titleArray;
    NSMutableArray *_docidArray;
    //存放URL地址的数组
    NSMutableArray *_imageUrlArray;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWithCount:(int)count;
@property (retain,nonatomic) UIScrollView *scorllView;
@property (retain,nonatomic) UILabel *titleLabel;
@property (retain,nonatomic) UIPageControl *pageControl;

@property (assign,nonatomic)  id<HeadCellDelegate> delegate;
-(void)setContent:(NSArray *)array ;
@end
