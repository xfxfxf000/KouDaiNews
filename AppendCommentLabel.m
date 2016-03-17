//
//  AppendCommentLabel.m


#import "AppendCommentLabel.h"

@implementation AppendCommentLabel


- (void)dealloc
{
    [_titleLabel release];
    [_contentLabel release];
    [_background release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
            // Initialization code
        [self makeView];
    }
    return self;

}
- (id)initWithFrame:(CGRect)frame andContentHeight:(CGFloat)height
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _contentHeight = height;
//        self.backgroundColor = [UIColor greenColor];
        [self makeView];
    }
    return self;
}

-(void)makeView{
    _background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kSIZE_WIDTH ,kSIZE_HEIGHT )];
    [_background setImage:[UIImage imageNamed:@"Append_Comment2"]];
    [self addSubview:_background];
    [_background release];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, kSIZE_HEIGHT-_contentHeight-20, kSIZE_WIDTH-10, 10)];
    _titleLabel.font = [UIFont systemFontOfSize:kAPPEND_CONTENT_FONT_SIZE];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLabel];
    [_titleLabel release];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, kSIZE_HEIGHT-_contentHeight-5, kSIZE_WIDTH-10, _contentHeight)];
    _contentLabel.font = [UIFont systemFontOfSize:kAPPEND_CONTENT_FONT_SIZE];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentLabel];
    [_contentLabel release];

}
-(void)setTitleLabelFrame:(CGRect)rect{
    _titleLabel.frame = CGRectMake(5, kSIZE_HEIGHT-_contentHeight-10, kSIZE_WIDTH-10, 10);
}
@end
