//
//  ContentCell.m


#import "ContentCell.h"
#import "UIImageView+WebCache.h"
@implementation ContentCell


- (void)dealloc
{
    [_contentLabel release];
    [_playerImageView release];
    [_imgSrc release];
    [_mImageView release];
    [_playerImageView release];
    [_playerView release];
    [_url_mp4 release];
    [_delegate release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self makeView];
    }
    return self;
}
-(void)makeView{
    //内容
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 310, 100)];//这个需要根据字的数量来决定
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.numberOfLines = 0;
    
    [_contentLabel setTextColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
    _contentLabel.font = [UIFont systemFontOfSize:kCONTENT_FONT_SIZE];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel release];
    //图片
    _mImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 5,200 , 135)];
    _mImageView.image = nil;
    _mImageView.backgroundColor = [UIColor grayColor];
    //点击图片可以进大图
    _mImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
    [_mImageView addGestureRecognizer:tap];
    [tap release];
    
    [self.contentView addSubview:_mImageView];
    [_mImageView release];
    //视频内容
    _playerView = [[UIView alloc]initWithFrame:CGRectMake(60, 5,200 , 140)];
    _playerView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_playerView];
    [_playerView release];
    
    _playerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5,180 , 120)];
    
    _playerImageView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    [_playerView addSubview:_playerImageView];
    [_playerImageView release];
    
    //button
    UIButton *playerButton = [CreateButton createCustomButton:[UIImage imageNamed:@"player.png"] andWithSEL:@selector(playerButtonClicked) andTarget:self andWithFrame:CGRectMake(76, 38.5, 48, 48)];
    [_playerView addSubview:playerButton];
    //title
    _playerTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 125, 190, 15)];
    _playerTitle.text = @"加载中...";
    _playerTitle.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _playerTitle.font = [UIFont systemFontOfSize:13];
    _playerTitle.textAlignment = NSTextAlignmentCenter;
    
    _playerTitle.backgroundColor = [UIColor clearColor];
    [_playerView addSubview:_playerTitle];
    [_playerTitle release];

}
//buttonClicked
-(void)playerButtonClicked{
    [self.delegate selectedImage:nil andType:Video otherURL:_url_mp4];
}
//点击图片
-(void)tapImage{
    [self.delegate selectedImage:_mImageView.image andType:Normal otherURL:nil];
}
//设置普通图片
-(void)setImageWithURL:(NSString *)url{
    
    
    [_mImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeHolderImage"] options:SDWebImageRetryFailed];

    _imgSrc = url;
}
//设置图片上的图片
-(void)setPlayerInfo:(VideoItem *)videoItem{
    _playerTitle.text =videoItem.alt;
    
    [_playerImageView setImageWithURL:[NSURL URLWithString:videoItem.cover] placeholderImage:[UIImage imageNamed:@"placeHolderImage"] options:SDWebImageRetryFailed];
    
    _url_mp4 = videoItem.url_mp4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
