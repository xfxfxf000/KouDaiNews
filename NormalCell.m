//
//  NormalCell.m

#import "NormalCell.h"
#import "UIImageView+WebCache.h"
@implementation NormalCell

- (void)dealloc
{
    [_titleLabel release];
    [_mImageView release];
    [_digestLabel release];
    [_replyLable release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self makeView];
    }
    return self;
}

-(void)makeView{
    
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    //图片
    _mImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 8, 100, 80)];
    _mImageView.backgroundColor = [UIColor grayColor];
    
    _mImageView.layer.borderWidth =2;
    _mImageView.layer.borderColor = [UIColor clearColor].CGColor;
    [_mImageView.layer setCornerRadius:10];
    [_mImageView.layer setMasksToBounds:YES];
    [self.contentView addSubview:_mImageView];
        [_mImageView release];
    //title
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 12, 220, 20)];
    _titleLabel.textColor = [UIColor darkGrayColor];
    //字号
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
    
    
    //digest
    _digestLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 34, 220, 28)];
    _digestLabel.font = [UIFont systemFontOfSize:12];
    _digestLabel.numberOfLines = 2;
    _digestLabel.textColor = [UIColor grayColor];
    //_digestLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_digestLabel];
        [_digestLabel release];
    
    //reply
    _replyLable = [[UILabel alloc]initWithFrame:CGRectMake(240, 70, 75, 14)];
    _replyLable.textAlignment= NSTextAlignmentRight;
    _replyLable.textColor =  [UIColor grayColor];
    _replyLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_replyLable];
    [_replyLable release];
}
-(void)setContentWithItem:(MainPageItems *)item{
    _titleLabel.text = item.title;
    _titleLabel.textColor = [UIColor blackColor];
    _digestLabel.text = item.digest;
    _replyLable.text = [NSString stringWithFormat:@"%@ 跟帖",item.replyCount];
    _mImageView.image = nil;
    [_mImageView setImageWithURL:[NSURL URLWithString:item.imgsrc] placeholderImage:[UIImage imageNamed:@"placeHolderImage"] options:SDWebImageRetryFailed];
}
-(void)setContentWIthItemOnlyWordage:(MainPageItems *)item{
    _titleLabel.text = item.title;
    _titleLabel.textColor = [UIColor blackColor];
    _digestLabel.text = item.digest;
    _replyLable.text = [NSString stringWithFormat:@"%@ 跟帖",item.replyCount];
    
    [_mImageView setImageWithURL:[NSURL URLWithString:item.imgsrc] placeholderImage:[UIImage imageNamed:@"placeHolderImage"] options:SDWebImageRetryFailed];
}
-(void)setImageWithURLString:(NSString *)urlStr{
    if (self.mImageView.image != nil) {
        return;
    }
    [_mImageView setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"placeHolderImage"] options:SDWebImageRetryFailed];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
