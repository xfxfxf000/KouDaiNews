//
//  NotExistsImageCell.m


#import "NotExistsImageCell.h"

@implementation NotExistsImageCell
- (void)dealloc
{
    [_titleLabel release];
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
    //title
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 310, 20)];
    //字号
    _titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel release];
    
    
    //digest
    _digestLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 24, 310, 28)];
    _digestLabel.font = [UIFont systemFontOfSize:12];
    _digestLabel.numberOfLines = 2;
    _digestLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.contentView addSubview:_digestLabel];
    [_digestLabel release];
    
    //reply
    
    _replyLable = [[UILabel alloc]initWithFrame:CGRectMake(240, 54, 75, 14)];
    _replyLable.textAlignment= NSTextAlignmentRight;
    _replyLable.textColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    _replyLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_replyLable];
    [_replyLable release];
}
-(void)setContentWithItem:(MainPageItems *)item{
    _titleLabel.text = item.title;
    _titleLabel.textColor = [UIColor lightGrayColor];
    _digestLabel.text = item.digest;
    _replyLable.text = [NSString stringWithFormat:@"%@ 跟帖",item.replyCount];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
