//
//  TitleCell.m

#import "TitleCell.h"

@implementation TitleCell

- (void)dealloc
{
    
    
    [_titleLabel release];
    [_sourcesLabel release];
    [_timeLabel release];
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
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 316, 20)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:kTITLE_LABEL_FONT_SIZE];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.numberOfLines = 0;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel release];
    
    _sourcesLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 24, 150, 12)];
    _sourcesLabel.font = [UIFont systemFontOfSize:kNORMAL_LABEL_FONT_SIZE];
    _sourcesLabel.backgroundColor = [UIColor clearColor];
    [_sourcesLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:_sourcesLabel];
    [_sourcesLabel release];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(320-102, 24, 100, 12)];
    _timeLabel.font = [UIFont systemFontOfSize:kNORMAL_LABEL_FONT_SIZE];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel release];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
